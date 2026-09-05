import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class Particle {
  double x;
  double y;
  double radius;
  double speedX;
  double speedY;
  double opacity;
  Color color;

  Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.speedX,
    required this.speedY,
    required this.opacity,
    required this.color,
  });
}

/// Interactive particle canvas that gently floats and connects close neighbors
class InteractiveParticleField extends StatefulWidget {
  final int particleCount;

  const InteractiveParticleField({
    super.key,
    this.particleCount = 45,
  });

  @override
  State<InteractiveParticleField> createState() => _InteractiveParticleFieldState();
}

class _InteractiveParticleFieldState extends State<InteractiveParticleField> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final math.Random _random = math.Random();
  Offset? _mousePosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _initParticles();
  }

  void _initParticles() {
    final List<Color> colors = [
      AppColors.cyan,
      AppColors.blue,
      AppColors.purple,
      AppColors.emerald,
    ];

    for (int i = 0; i < widget.particleCount; i++) {
      _particles.add(
        Particle(
          x: _random.nextDouble(),
          y: _random.nextDouble(),
          radius: _random.nextDouble() * 2.2 + 0.8,
          speedX: (_random.nextDouble() - 0.5) * 0.0004,
          speedY: (_random.nextDouble() - 0.5) * 0.0004,
          opacity: _random.nextDouble() * 0.5 + 0.2,
          color: colors[_random.nextInt(colors.length)],
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePosition = event.localPosition;
        });
      },
      onExit: (_) {
        setState(() {
          _mousePosition = null;
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size.infinite,
            painter: _ParticlePainter(
              particles: _particles,
              mousePosition: _mousePosition,
            ),
          );
        },
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Offset? mousePosition;

  _ParticlePainter({
    required this.particles,
    this.mousePosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    final Paint particlePaint = Paint()..style = PaintingStyle.fill;
    final Paint linePaint = Paint()
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Update positions
    for (int i = 0; i < particles.length; i++) {
      final p = particles[i];
      p.x += p.speedX;
      p.y += p.speedY;

      if (p.x < 0) p.x = 1.0;
      if (p.x > 1) p.x = 0.0;
      if (p.y < 0) p.y = 1.0;
      if (p.y > 1) p.y = 0.0;

      final Offset pos = Offset(p.x * size.width, p.y * size.height);

      // Mouse repulsion/attraction
      if (mousePosition != null) {
        final double dist = (pos - mousePosition!).distance;
        if (dist < 100) {
          canvas.drawLine(
            pos,
            mousePosition!,
            Paint()
              ..color = AppColors.cyan.withValues(alpha: 0.15 * (1 - dist / 100))
              ..strokeWidth = 0.8,
          );
        }
      }

      particlePaint.color = p.color.withValues(alpha: p.opacity);
      canvas.drawCircle(pos, p.radius, particlePaint);

      // Connecting lines between nearby particles
      for (int j = i + 1; j < particles.length; j++) {
        final p2 = particles[j];
        final Offset pos2 = Offset(p2.x * size.width, p2.y * size.height);
        final double distance = (pos - pos2).distance;

        if (distance < 90) {
          linePaint.color = p.color.withValues(alpha: 0.12 * (1 - distance / 90));
          canvas.drawLine(pos, pos2, linePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
