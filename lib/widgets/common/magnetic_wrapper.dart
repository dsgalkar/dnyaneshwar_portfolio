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

  void _onHover(PointerEvent event, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double dx = (event.localPosition.dx - centerX) / centerX;
    final double dy = (event.localPosition.dy - centerY) / centerY;

    setState(() {
      _offset = Offset(dx * widget.maxOffset, dy * widget.maxOffset);
    });
  }

  void _onExit() {
    setState(() {
      _offset = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onHover: (event) => _onHover(event, Size(constraints.maxWidth, constraints.maxHeight)),
          onExit: (_) => _onExit(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: CustomCurves.magnetic,
            transform: Matrix4.translationValues(_offset.dx, _offset.dy, 0),
            child: widget.child,
          ),
        );
      },
    );
  }
}
