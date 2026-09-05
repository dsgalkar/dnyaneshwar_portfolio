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

  void _onPointerHover(PointerEvent event, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double localX = event.localPosition.dx;
    final double localY = event.localPosition.dy;

    setState(() {
      _tiltX = ((localY - centerY) / centerY) * -widget.maxTiltAngle;
      _tiltY = ((localX - centerX) / centerX) * widget.maxTiltAngle;
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
    final Color glow = widget.glowColor ?? AppColors.cyan;

    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
          onEnter: (_) => setState(() => _isHovered = true),
          onHover: (event) => _onPointerHover(event, Size(constraints.maxWidth, constraints.maxHeight)),
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
                          color: glow.withValues(alpha: 0.25),
                          blurRadius: 25,
                          spreadRadius: 2,
                          offset: const Offset(0, 10),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
              ),
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
