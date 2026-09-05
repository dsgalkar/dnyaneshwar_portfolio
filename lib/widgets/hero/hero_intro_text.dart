import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/animations/reveal_animation.dart';
import '../../core/utils/responsive.dart';
import '../../data/portfolio_data.dart';
import '../common/glow_button.dart';
import '../common/magnetic_wrapper.dart';
import 'typewriter_text.dart';

/// Left-hand side content of the Hero Section with introduction, headline, and Action buttons
class HeroIntroText extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onDownloadResume;
  final VoidCallback onContactMe;

  const HeroIntroText({
    super.key,
    required this.onViewWork,
    required this.onDownloadResume,
    required this.onContactMe,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Greeting Pill
        RevealAnimation(
          delay: const Duration(milliseconds: 100),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.cyan.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.cyan.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.emerald,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: AppColors.emerald, blurRadius: 6, spreadRadius: 1),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Available for Internships & Projects',
                  style: AppTypography.codeFont(
                    color: AppColors.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Main Name & Role Headline
        RevealAnimation(
          delay: const Duration(milliseconds: 250),
          child: Column(
            crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(
                "Hi, I'm Dnyaneshwar",
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.cyan,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Computer Engineering Student\n& Developer',
                style: AppTypography.heroHeading(
                  context,
                  fontSize: isMobile ? 34 : 48,
                ),
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Rotating Typewriter Subtitle
        RevealAnimation(
          delay: const Duration(milliseconds: 400),
          child: TypewriterText(
            texts: PortfolioData.rotatingTitles,
            style: AppTypography.heroSubHeading.copyWith(
              fontSize: isMobile ? 20 : 26,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Short Tagline Description
        RevealAnimation(
          delay: const Duration(milliseconds: 550),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 540),
            child: Text(
              PortfolioData.tagline,
              style: AppTypography.bodyLarge,
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
          ),
        ),

        const SizedBox(height: 36),

        // Action Buttons Row
        RevealAnimation(
          delay: const Duration(milliseconds: 700),
          child: Wrap(
            spacing: 14,
            runSpacing: 14,
            alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
            children: [
              MagneticWrapper(
                child: GlowButton(
                  text: 'View My Work',
                  icon: Icons.grid_view_rounded,
                  variant: GlowButtonVariant.primary,
                  onPressed: onViewWork,
                ),
              ),
              MagneticWrapper(
                child: GlowButton(
                  text: 'Download Resume',
                  icon: Icons.download_rounded,
                  variant: GlowButtonVariant.secondary,
                  onPressed: onDownloadResume,
                ),
              ),
              MagneticWrapper(
                child: GlowButton(
                  text: 'Contact Me',
                  icon: Icons.mail_outline_rounded,
                  variant: GlowButtonVariant.outline,
                  onPressed: onContactMe,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
