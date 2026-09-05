import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../models/experience_model.dart';
import '../common/glass_container.dart';
import '../common/tech_badge.dart';

/// Glowing vertical timeline node with card and connecting laser trace
class GlowingTimelineItem extends StatelessWidget {
  final ExperienceModel experience;
  final bool isLast;

  const GlowingTimelineItem({
    super.key,
    required this.experience,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Glowing Timeline Node & Connector Line
          SizedBox(
            width: 44,
            child: Column(
              children: [
                // Glowing Circle Node
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surfaceElevated,
                    border: Border.all(color: AppColors.cyan, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.cyan.withValues(alpha: 0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(experience.icon, style: const TextStyle(fontSize: 14)),
                ),

                // Connecting Laser Line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.cyan, AppColors.purple, Color(0x1F7F00FF)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Right: Content Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28.0),
              child: GlassContainer(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Period & Role Pill
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.cyan.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            experience.period,
                            style: AppTypography.codeFont(
                              color: AppColors.cyan,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.purple.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            experience.roleType,
                            style: AppTypography.badge.copyWith(color: AppColors.purple),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Role Title
                    Text(
                      experience.title,
                      style: AppTypography.cardTitle.copyWith(fontSize: 19),
                    ),

                    const SizedBox(height: 4),

                    // Organization
                    Text(
                      experience.organization,
                      style: AppTypography.bodyMedium.copyWith(color: AppColors.cyan, fontWeight: FontWeight.w500),
                    ),

                    const SizedBox(height: 12),

                    // Description
                    Text(
                      experience.description,
                      style: AppTypography.bodySmall,
                    ),

                    const SizedBox(height: 14),

                    // Highlights
                    for (final highlight in experience.highlights) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('▹ ', style: TextStyle(color: AppColors.cyan, fontSize: 13)),
                            Expanded(
                              child: Text(
                                highlight,
                                style: AppTypography.bodySmall.copyWith(color: AppColors.textPrimary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 14),

                    // Tags
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: experience.tags.map((tag) {
                        return TechBadge(label: tag, color: AppColors.blue);
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
