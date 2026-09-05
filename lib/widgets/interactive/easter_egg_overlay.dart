import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../common/glow_button.dart';

/// Pleasant Developer Easter Egg celebration overlay
class EasterEggOverlay extends StatefulWidget {
  final VoidCallback onClose;

  const EasterEggOverlay({super.key, required this.onClose});

  @override
  State<EasterEggOverlay> createState() => _EasterEggOverlayState();
}

class _EasterEggOverlayState extends State<EasterEggOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<double> _drops = List.generate(35, (index) => math.Random().nextDouble() * 500);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF0F172A).withValues(alpha: 0.4),
      child: Stack(
        children: [
          // Gentle Pastel Floating Stream
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: _PastelParticlePainter(drops: _drops),
              );
            },
          ),

          // Central Celebratory Card
          Center(
            child: Container(
              padding: const EdgeInsets.all(36),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              constraints: const BoxConstraints(maxWidth: 520),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.primaryIndigo.withValues(alpha: 0.2), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryIndigo.withValues(alpha: 0.15),
                    blurRadius: 36,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.primaryIndigo.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text('✨', style: TextStyle(fontSize: 32)),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'DEVELOPER SHOWCASE DEMO',
                    style: AppTypography.codeFont(
                      color: AppColors.primaryIndigo,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    '"Simplicity is prerequisite for reliability."\n— Edsger W. Dijkstra',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Crafted with mechanical sympathy by Dnyaneshwar Galkar using Flutter & Dart Canvas Engine.',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  GlowButton(
                    text: 'Return to Portfolio',
                    icon: Icons.check_circle_outline_rounded,
                    variant: GlowButtonVariant.primary,
                    onPressed: widget.onClose,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PastelParticlePainter extends CustomPainter {
  final List<double> drops;
  static const String symbols = '✨✦•·⚡🛡️💻';
  final math.Random random = math.Random();

  _PastelParticlePainter({required this.drops});

  @override
  void paint(Canvas canvas, Size size) {
    final TextStyle textStyle = TextStyle(
      color: AppColors.primaryIndigo.withValues(alpha: 0.35),
      fontSize: 14,
      fontFamily: 'monospace',
      fontWeight: FontWeight.bold,
    );

    final double colWidth = size.width / drops.length;

    for (int i = 0; i < drops.length; i++) {
      drops[i] += 4.0;
      if (drops[i] > size.height) {
        drops[i] = 0;
      }

      final symbol = symbols[random.nextInt(symbols.length)];
      final textSpan = TextSpan(text: symbol, style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(canvas, Offset(i * colWidth, drops[i]));
    }
  }

  @override
  bool shouldRepaint(covariant _PastelParticlePainter oldDelegate) => true;
}
