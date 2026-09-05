import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Section Header with futuristic number tag, gradient title, and glowing accent line
class SectionTitle extends StatelessWidget {
  final String number;
  final String title;
  final String? subtitle;
  final bool isCenter;

  const SectionTitle({
    super.key,
    required this.number,
    required this.title,
    this.subtitle,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$number //',
              style: AppTypography.codeFont(
                color: AppColors.cyan,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 1,
              width: 35,
              color: AppColors.cyan.withValues(alpha: 0.5),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.textPrimary, Color(0xFFB0C4DE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            title,
            style: AppTypography.sectionTitle,
            textAlign: isCenter ? TextAlign.center : TextAlign.start,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              subtitle!,
              style: AppTypography.sectionSubtitle,
              textAlign: isCenter ? TextAlign.center : TextAlign.start,
            ),
          ),
        ],
        const SizedBox(height: 32),
      ],
    );
  }
}
