import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Lightweight CustomPainter drawing a subtle futuristic cyber grid with glowing intersection nodes
class DigitalGridPainter extends CustomPainter {
  final double progress;
  final double gridSize;
  final Color gridColor;

  DigitalGridPainter({
    this.progress = 1.0,
    this.gridSize = 60.0,
    this.gridColor = const Color(0x0C00F2FE),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final Paint dotPaint = Paint()
      ..color = AppColors.cyan.withValues(alpha: 0.12 * progress)
      ..style = PaintingStyle.fill;

    // Draw vertical lines
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height * progress), linePaint);
    }

    // Draw horizontal lines
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width * progress, y), linePaint);
    }

    // Draw glowing crosshairs at grid intersections
    for (double x = 0; x <= size.width; x += gridSize * 2) {
      for (double y = 0; y <= size.height; y += gridSize * 2) {
        canvas.drawCircle(Offset(x, y), 1.8, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DigitalGridPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.gridColor != gridColor;
  }
}
