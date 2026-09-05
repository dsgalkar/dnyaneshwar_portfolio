import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Matrix Rain / Developer Easter Egg Screen Overlay
class EasterEggOverlay extends StatefulWidget {
  final VoidCallback onClose;

  const EasterEggOverlay({super.key, required this.onClose});

  @override
  State<EasterEggOverlay> createState() => _EasterEggOverlayState();
}

class _EasterEggOverlayState extends State<EasterEggOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<double> _drops = List.generate(40, (index) => math.Random().nextDouble() * 500);

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
      color: Colors.black.withValues(alpha: 0.92),
      child: Stack(
        children: [
          // Matrix Rain Painter
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: _MatrixRainPainter(drops: _drops),
              );
            },
          ),

          // Central Message
          Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              constraints: const BoxConstraints(maxWidth: 550),
              decoration: BoxDecoration(
                color: AppColors.terminalBg.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.terminalGreen, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.terminalGreen.withValues(alpha: 0.4),
                    blurRadius: 30,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🚀', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 16),
                  Text(
                    'DEVELOPER EASTER EGG UNLOCKED',
                    style: AppTypography.codeFont(
                      color: AppColors.terminalGreen,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '"Simplicity is prerequisite for reliability."\n— Edsger W. Dijkstra',
                    style: AppTypography.codeFont(
                      color: AppColors.cyan,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Crafted by Dnyaneshwar Galkar using Flutter & Dart Canvas Engine.',
                    style: AppTypography.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: widget.onClose,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.terminalGreen,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                    ),
                    child: Text('Return to Matrix', style: AppTypography.codeFont(color: Colors.black, fontWeight: FontWeight.w800)),
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

class _MatrixRainPainter extends CustomPainter {
  final List<double> drops;
  static const String chars = '0123456789ABCDEF01FLUTTERDARTLINUX';
  final math.Random random = math.Random();

  _MatrixRainPainter({required this.drops});

  @override
  void paint(Canvas canvas, Size size) {
    final TextStyle textStyle = TextStyle(
      color: AppColors.terminalGreen.withValues(alpha: 0.8),
      fontSize: 14,
      fontFamily: 'monospace',
      fontWeight: FontWeight.bold,
    );

    final double colWidth = size.width / drops.length;

    for (int i = 0; i < drops.length; i++) {
      drops[i] += 8.0;
      if (drops[i] > size.height) {
        drops[i] = 0;
      }

      final char = chars[random.nextInt(chars.length)];
      final textSpan = TextSpan(text: char, style: textStyle);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(canvas, Offset(i * colWidth, drops[i]));
    }
  }

  @override
  bool shouldRepaint(covariant _MatrixRainPainter oldDelegate) => true;
}
