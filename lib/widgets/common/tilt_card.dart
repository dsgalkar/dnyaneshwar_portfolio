import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/animations/custom_curves.dart';

/// 3D Perspective Card that responds smoothly to mouse cursor position
class TiltCard extends StatefulWidget {
  final Widget child;
  final double maxTiltAngle;
  final double borderRadius;
  final Color? glowColor;
  final VoidCallback? onTap;

  const TiltCard({
    super.key,
    required this.child,
    this.maxTiltAngle = 0.08,
    this.borderRadius = 16.0,
    this.glowColor,
    this.onTap,
  });

  @override
  State<TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<TiltCard> {
  double _tiltX = 0.0;
  double _tiltY = 0.0;
  bool _isHovered = false;

  void _onPointerHover(PointerEvent event) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final Size size = box.size;
    if (size.width <= 0 || size.height <= 0 || size.width.isInfinite || size.height.isInfinite) return;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    if (centerX == 0 || centerY == 0) return;

    final double localX = event.localPosition.dx;
    final double localY = event.localPosition.dy;

    final double normY = ((localY - centerY) / centerY).clamp(-1.0, 1.0);
    final double normX = ((localX - centerX) / centerX).clamp(-1.0, 1.0);

    if (normX.isNaN || normY.isNaN) return;

    setState(() {
      _tiltX = normY * -widget.maxTiltAngle;
      _tiltY = normX * widget.maxTiltAngle;
    });
  }

  void _onPointerExit() {
    setState(() {
      _tiltX = 0.0;
      _tiltY = 0.0;
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color glow = widget.glowColor ?? AppColors.primaryIndigo;

    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onHover: _onPointerHover,
      onExit: (_) => _onPointerExit(),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: CustomCurves.easeOutCubic,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // perspective
            ..rotateX(_tiltX)
            ..rotateY(_tiltY)
            ..scaleByDouble(_isHovered ? 1.02 : 1.0, _isHovered ? 1.02 : 1.0, 1.0, 1.0),
          transformAlignment: FractionalOffset.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: glow.withValues(alpha: 0.15),
                      blurRadius: 20,
                      spreadRadius: 1,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: AppColors.slate900.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
