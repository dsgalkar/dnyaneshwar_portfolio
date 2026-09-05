import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Clean cyber tech badge for tags and stacks
class TechBadge extends StatelessWidget {
  final String label;
  final Color? color;
  final IconData? icon;
  final bool isGlowing;

  const TechBadge({
    super.key,
    required this.label,
    this.color,
    this.icon,
    this.isGlowing = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color badgeColor = color ?? AppColors.cyan;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: badgeColor.withValues(alpha: isGlowing ? 0.7 : 0.25),
          width: 1,
        ),
        boxShadow: isGlowing
            ? [
                BoxShadow(
                  color: badgeColor.withValues(alpha: 0.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: badgeColor),
            const SizedBox(width: 5),
          ],
          Flexible(
            child: Text(
              label,
              style: AppTypography.badge.copyWith(
                color: badgeColor,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
