import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Cinematic Multi-Layer Gradient Blob canvas that undulates slowly
class AnimatedMeshGradient extends StatefulWidget {
  final Widget child;

  const AnimatedMeshGradient({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedMeshGradient> createState() => _AnimatedMeshGradientState();
}

class _AnimatedMeshGradientState extends State<AnimatedMeshGradient> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base dark background
        Container(color: AppColors.background),

        // Animated organic glowing blobs
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final double t = _controller.value * 2 * math.pi;

            return CustomPaint(
              size: Size.infinite,
              painter: _MeshGradientPainter(time: t),
            );
          },
        ),

        // Content
        widget.child,
      ],
    );
  }
}

class _MeshGradientPainter extends CustomPainter {
  final double time;

  _MeshGradientPainter({required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    // Blob 1: Top-Left Cyan/Blue
    final Offset blob1Center = Offset(
      size.width * 0.2 + math.sin(time) * 60,
      size.height * 0.15 + math.cos(time * 0.8) * 40,
    );
    final Paint blob1Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.cyan.withValues(alpha: 0.08),
          AppColors.blue.withValues(alpha: 0.03),
          Colors.transparent,
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Rect.fromCircle(center: blob1Center, radius: size.width * 0.45));
    canvas.drawCircle(blob1Center, size.width * 0.45, blob1Paint);

    // Blob 2: Middle-Right Purple/Violet
    final Offset blob2Center = Offset(
      size.width * 0.85 + math.cos(time * 0.7) * 70,
      size.height * 0.5 + math.sin(time * 0.9) * 60,
    );
    final Paint blob2Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.purple.withValues(alpha: 0.09),
          AppColors.electricViolet.withValues(alpha: 0.04),
          Colors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: blob2Center, radius: size.width * 0.4));
    canvas.drawCircle(blob2Center, size.width * 0.4, blob2Paint);

    // Blob 3: Bottom-Left Emerald/Cyan
    final Offset blob3Center = Offset(
      size.width * 0.3 + math.sin(time * 1.1) * 50,
      size.height * 0.85 + math.cos(time * 0.6) * 50,
    );
    final Paint blob3Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.emerald.withValues(alpha: 0.06),
          AppColors.cyan.withValues(alpha: 0.02),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 1.0],
      ).createShader(Rect.fromCircle(center: blob3Center, radius: size.width * 0.35));
    canvas.drawCircle(blob3Center, size.width * 0.35, blob3Paint);
  }

  @override
  bool shouldRepaint(covariant _MeshGradientPainter oldDelegate) => oldDelegate.time != time;
}
