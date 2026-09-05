import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/responsive.dart';
import '../../core/animations/reveal_animation.dart';
import '../../data/portfolio_data.dart';
import '../../models/activity_model.dart';
import '../common/glass_container.dart';
import '../common/tech_badge.dart';
import '../common/tilt_card.dart';

/// Interactive Grid of VAMINT Hackathons, Bootcamps and Leadership Initiatives
class VamintEventGrid extends StatelessWidget {
  const VamintEventGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final int crossAxisCount = isDesktop ? 2 : 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double itemWidth = (constraints.maxWidth - (crossAxisCount - 1) * 16) / crossAxisCount;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: PortfolioData.vamintActivities.map((act) {
            return SizedBox(
              width: itemWidth,
              child: RevealAnimation(
                delay: Duration(milliseconds: 100 * PortfolioData.vamintActivities.indexOf(act)),
                child: _VamintActivityCard(activity: act),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _VamintActivityCard extends StatelessWidget {
  final ActivityModel activity;

  const _VamintActivityCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    return TiltCard(
      glowColor: AppColors.purple,
      child: GlassContainer(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(activity.icon, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.purple.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        activity.eventType,
                        style: AppTypography.badge.copyWith(color: AppColors.purple),
                      ),
                    ),
                  ],
                ),
                Text(
                  activity.date,
                  style: AppTypography.codeFont(color: AppColors.cyan, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Text(
              activity.title,
              style: AppTypography.cardTitle.copyWith(fontSize: 18),
            ),

            const SizedBox(height: 8),

            Text(
              activity.description,
              style: AppTypography.bodySmall,
            ),

            const SizedBox(height: 12),

            // Impact Callout
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.emerald.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.emerald.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.trending_up_rounded, color: AppColors.emerald, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Impact: ${activity.impact}',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.emerald,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: activity.tags.map((t) => TechBadge(label: t, color: AppColors.blue)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
