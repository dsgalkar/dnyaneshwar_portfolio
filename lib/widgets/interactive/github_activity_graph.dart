import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/url_helper.dart';
import '../../data/portfolio_data.dart';
import '../common/glass_container.dart';
import '../common/glow_button.dart';

/// Simulated GitHub Contribution Heatmap with interactive cell tooltips
class GithubActivityGraph extends StatelessWidget {
  const GithubActivityGraph({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate deterministic grid pattern
    final math.Random random = math.Random(42);
    final List<List<int>> contributionWeeks = List.generate(24, (week) {
      return List.generate(7, (day) {
        // Skewed probability towards active coding days
        final double r = random.nextDouble();
        if (r > 0.82) return 4;
        if (r > 0.60) return 3;
        if (r > 0.38) return 2;
        if (r > 0.18) return 1;
        return 0;
      });
    });

    return GlassContainer(
      padding: const EdgeInsets.all(22),
      borderRadius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.commit_rounded, color: AppColors.cyan, size: 22),
                  const SizedBox(width: 10),
                  Text('GitHub Activity & Consistency', style: AppTypography.cardTitle.copyWith(fontSize: 18)),
                ],
              ),
              GlowButton(
                text: 'View GitHub Profile',
                icon: Icons.open_in_new_rounded,
                height: 34,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                variant: GlowButtonVariant.outline,
                onPressed: () => UrlHelper.launchURL(PortfolioData.githubUrl),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            '1,200+ contributions in the past year across open-source repositories and personal builds.',
            style: AppTypography.bodySmall,
          ),

          const SizedBox(height: 18),

          // Contribution Heatmap Canvas
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int w = 0; w < contributionWeeks.length; w++) ...[
                  Column(
                    children: [
                      for (int d = 0; d < 7; d++) ...[
                        _HeatmapCell(level: contributionWeeks[w][d]),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Heatmap Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Less', style: AppTypography.codeFont(color: AppColors.textMuted, fontSize: 11)),
              const SizedBox(width: 6),
              for (int lvl = 0; lvl <= 4; lvl++) _HeatmapCell(level: lvl, isStatic: true),
              const SizedBox(width: 6),
              Text('More', style: AppTypography.codeFont(color: AppColors.textMuted, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeatmapCell extends StatelessWidget {
  final int level;
  final bool isStatic;

  const _HeatmapCell({required this.level, this.isStatic = false});

  @override
  Widget build(BuildContext context) {
    Color cellColor;
    switch (level) {
      case 4:
        cellColor = AppColors.emerald;
        break;
      case 3:
        cellColor = AppColors.cyan;
        break;
      case 2:
        cellColor = const Color(0xFF0E7490);
        break;
      case 1:
        cellColor = const Color(0xFF164E63);
        break;
      default:
        cellColor = AppColors.surfaceElevated.withValues(alpha: 0.6);
        break;
    }

    final Widget box = Container(
      width: 13,
      height: 13,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: cellColor,
        borderRadius: BorderRadius.circular(3),
        boxShadow: level >= 3
            ? [
                BoxShadow(
                  color: cellColor.withValues(alpha: 0.4),
                  blurRadius: 4,
                  spreadRadius: 0.5,
                ),
              ]
            : null,
      ),
    );

    if (isStatic) return box;

    return Tooltip(
      message: level > 0 ? '$level+ commits on this date' : 'No commits on this date',
      child: box,
    );
  }
}
