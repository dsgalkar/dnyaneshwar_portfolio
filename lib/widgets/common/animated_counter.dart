import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/animations/custom_curves.dart';

/// Animated numerical counter that rolls up smoothly
class AnimatedCounter extends StatefulWidget {
  final int targetValue;
  final String suffix;
  final String label;
  final String icon;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.targetValue,
    this.suffix = '',
    required this.label,
    required this.icon,
    this.duration = const Duration(milliseconds: 1800),
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = IntTween(begin: 0, end: widget.targetValue).animate(
      CurvedAnimation(parent: _controller, curve: CustomCurves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.icon,
          style: const TextStyle(fontSize: 28),
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.primaryIndigo, AppColors.secondarySky],
              ).createShader(bounds),
              child: Text(
                '${_animation.value}${widget.suffix}',
                style: GoogleFonts.outfit(
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 4),
        Text(
          widget.label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
