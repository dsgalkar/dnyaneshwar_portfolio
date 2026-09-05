import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/animations/reveal_animation.dart';
import '../../core/utils/responsive.dart';
import '../../data/portfolio_data.dart';
import '../common/animated_counter.dart';
import '../common/glass_container.dart';

/// Animated Statistics Grid with glowing metrics cards
class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return RevealAnimation(
      delay: const Duration(milliseconds: 200),
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        borderRadius: 20,
        child: isMobile
            ? Column(
                children: [
                  for (int i = 0; i < PortfolioData.stats.length; i++) ...[
                    AnimatedCounter(
                      targetValue: PortfolioData.stats[i].count,
                      suffix: PortfolioData.stats[i].suffix,
                      label: PortfolioData.stats[i].label,
                      icon: PortfolioData.stats[i].icon,
                    ),
                    if (i != PortfolioData.stats.length - 1)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Divider(color: AppColors.surfaceGlassBorder, height: 1),
                      ),
                  ],
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < PortfolioData.stats.length; i++) ...[
                    Expanded(
                      child: AnimatedCounter(
                        targetValue: PortfolioData.stats[i].count,
                        suffix: PortfolioData.stats[i].suffix,
                        label: PortfolioData.stats[i].label,
                        icon: PortfolioData.stats[i].icon,
                      ),
                    ),
                    if (i != PortfolioData.stats.length - 1)
                      Container(
                        height: 50,
                        width: 1,
                        color: AppColors.surfaceGlassBorder,
                      ),
                  ],
                ],
              ),
      ),
    );
  }
}
