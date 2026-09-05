import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Glowing Scroll Progress Bar at the top of the viewport
class ScrollProgressBar extends StatelessWidget {
  final double progress;

  const ScrollProgressBar({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 3,
        alignment: Alignment.centerLeft,
        color: Colors.transparent,
        child: FractionallySizedBox(
          widthFactor: progress.clamp(0.0, 1.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.cyan, AppColors.blue, AppColors.purple],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cyan.withValues(alpha: 0.8),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
