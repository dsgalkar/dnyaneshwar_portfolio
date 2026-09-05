import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../models/achievement_model.dart';
import '../common/glass_container.dart';
import '../common/tech_badge.dart';
import '../common/tilt_card.dart';
import 'certificate_modal.dart';

/// Achievement Badge Card with 3D Depth and click-to-preview
class AchievementBadgeCard extends StatelessWidget {
  final AchievementModel achievement;

  const AchievementBadgeCard({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    return TiltCard(
      glowColor: AppColors.cyan,
      onTap: () => _showCertificate(context),
      child: GlassContainer(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cyan.withValues(alpha: 0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(achievement.badgeIcon, style: const TextStyle(fontSize: 22)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.cyan.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        achievement.category,
                        style: AppTypography.badge.copyWith(color: AppColors.cyan),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                Text(
                  achievement.title,
                  style: AppTypography.cardTitle.copyWith(fontSize: 18),
                ),

                const SizedBox(height: 4),

                Text(
                  achievement.issuer,
                  style: AppTypography.codeFont(color: AppColors.cyan, fontSize: 12),
                ),

                const SizedBox(height: 10),

                Text(
                  achievement.description,
                  style: AppTypography.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: achievement.skillsGained.take(3).map((s) => TechBadge(label: s, color: AppColors.blue)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showCertificate(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (context) => CertificateModal(achievement: achievement),
    );
  }
}
