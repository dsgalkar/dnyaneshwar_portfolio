import 'package:flutter/material.dart';
import '../../core/animations/custom_curves.dart';

/// Wraps widgets to subtly follow the mouse cursor within proximity
class MagneticWrapper extends StatefulWidget {
  final Widget child;
  final double maxOffset;

  const MagneticWrapper({
    super.key,
    required this.child,
    this.maxOffset = 10.0,
  });

  @override
  State<MagneticWrapper> createState() => _MagneticWrapperState();
}

class _MagneticWrapperState extends State<MagneticWrapper> {
  Offset _offset = Offset.zero;

  void _onHover(PointerEvent event) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final Size size = box.size;
    if (size.width <= 0 || size.height <= 0 || size.width.isInfinite || size.height.isInfinite) return;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    if (centerX == 0 || centerY == 0) return;

    final double dx = ((event.localPosition.dx - centerX) / centerX).clamp(-1.0, 1.0);
    final double dy = ((event.localPosition.dy - centerY) / centerY).clamp(-1.0, 1.0);

    if (dx.isNaN || dy.isNaN) return;

    setState(() {
      _offset = Offset(dx * widget.maxOffset, dy * widget.maxOffset);
    });
  }

  void _onExit() {
    if (_offset != Offset.zero) {
      setState(() {
        _offset = Offset.zero;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: _onHover,
      onExit: (_) => _onExit(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: CustomCurves.magnetic,
        transform: Matrix4.translationValues(_offset.dx, _offset.dy, 0),
        child: widget.child,
      ),
    );
  }
}
