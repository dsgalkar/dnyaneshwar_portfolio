import 'package:flutter/material.dart';
import 'custom_curves.dart';

enum RevealDirection { bottom, top, left, right, scale }

/// Wraps any widget to animate smoothly into view with custom offset, delay and curve
class RevealAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final RevealDirection direction;
  final double offsetDistance;
  final Curve curve;

  const RevealAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 700),
    this.delay = Duration.zero,
    this.direction = RevealDirection.bottom,
    this.offsetDistance = 40.0,
    this.curve = CustomCurves.easeOutCubic,
  });

  @override
  State<RevealAnimation> createState() => _RevealAnimationState();
}

class _RevealAnimationState extends State<RevealAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    Offset beginOffset = Offset.zero;
    switch (widget.direction) {
      case RevealDirection.bottom:
        beginOffset = Offset(0, widget.offsetDistance / 100);
        break;
      case RevealDirection.top:
        beginOffset = Offset(0, -widget.offsetDistance / 100);
        break;
      case RevealDirection.left:
        beginOffset = Offset(-widget.offsetDistance / 100, 0);
        break;
      case RevealDirection.right:
        beginOffset = Offset(widget.offsetDistance / 100, 0);
        break;
      case RevealDirection.scale:
        beginOffset = Offset.zero;
        break;
    }

    _slideAnimation = Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    _scaleAnimation = Tween<double>(begin: widget.direction == RevealDirection.scale ? 0.85 : 1.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: SlideTransition(
              position: _slideAnimation,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
