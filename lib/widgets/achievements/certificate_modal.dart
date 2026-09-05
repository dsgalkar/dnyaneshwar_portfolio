import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/url_helper.dart';
import '../../models/achievement_model.dart';
import '../common/glow_button.dart';
import '../common/tech_badge.dart';

/// Modal displaying verified credential, issuer, date, and skills acquired
class CertificateModal extends StatelessWidget {
  final AchievementModel achievement;

  const CertificateModal({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 550),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.cyan.withValues(alpha: 0.3), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyan.withValues(alpha: 0.2),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: Text(achievement.badgeIcon, style: const TextStyle(fontSize: 26)),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    achievement.title,
                    style: AppTypography.cardTitle.copyWith(fontSize: 22),
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Text(
                        achievement.issuer,
                        style: AppTypography.codeFont(color: AppColors.cyan, fontSize: 13, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 8),
                      const Text('•', style: TextStyle(color: AppColors.textMuted)),
                      const SizedBox(width: 8),
                      Text(
                        achievement.date,
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Text(
                    achievement.description,
                    style: AppTypography.bodyMedium,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Skills & Competencies Demonstrated:',
                    style: AppTypography.codeFont(color: AppColors.emerald, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: achievement.skillsGained.map((s) => TechBadge(label: s, color: AppColors.emerald)).toList(),
                  ),

                  const SizedBox(height: 28),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (achievement.credentialUrl != null) ...[
                        GlowButton(
                          text: 'Verify Credential',
                          icon: Icons.verified_user_outlined,
                          variant: GlowButtonVariant.primary,
                          onPressed: () => UrlHelper.launchURL(achievement.credentialUrl!),
                        ),
                      ] else ...[
                        GlowButton(
                          text: 'Close',
                          variant: GlowButtonVariant.secondary,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
