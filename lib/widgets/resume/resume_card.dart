import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/url_helper.dart';
import '../../models/resume_model.dart';
import '../common/glass_container.dart';
import '../common/glow_button.dart';
import '../common/tech_badge.dart';
import '../common/tilt_card.dart';
import 'resume_viewer_dialog.dart';

/// Card component for an individual tailored resume with View & Download actions
class ResumeCard extends StatelessWidget {
  final ResumeModel resume;

  const ResumeCard({super.key, required this.resume});

  @override
  Widget build(BuildContext context) {
    return TiltCard(
      glowColor: resume.isPrimary ? AppColors.cyan : AppColors.blue,
      onTap: () => _openViewer(context),
      child: GlassContainer(
        padding: const EdgeInsets.all(24),
        borderColor: resume.isPrimary ? AppColors.cyan.withValues(alpha: 0.5) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.cyan.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.cyan.withValues(alpha: 0.35)),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.description_outlined, color: AppColors.cyan, size: 24),
                    ),
                    Row(
                      children: [
                        if (resume.isPrimary) ...[
                          const TechBadge(label: 'PRIMARY', color: AppColors.emerald, isGlowing: true),
                          const SizedBox(width: 6),
                        ],
                        TechBadge(label: resume.badge, color: AppColors.blue),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Title & Focus
                Text(
                  resume.title,
                  style: AppTypography.cardTitle.copyWith(fontSize: 18),
                ),

                const SizedBox(height: 4),

                Text(
                  resume.roleFocus,
                  style: AppTypography.codeFont(color: AppColors.cyan, fontSize: 12),
                ),

                const SizedBox(height: 12),

                // Summary Points
                for (final p in resume.summaryPoints.take(2)) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('▹ ', style: TextStyle(color: AppColors.cyan, fontSize: 12)),
                        Expanded(
                          child: Text(
                            p,
                            style: AppTypography.bodySmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 20),

            // Action Buttons Row
            Row(
              children: [
                Expanded(
                  child: GlowButton(
                    text: 'View',
                    icon: Icons.visibility_outlined,
                    height: 38,
                    variant: GlowButtonVariant.secondary,
                    onPressed: () => _openViewer(context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GlowButton(
                    text: 'Download',
                    icon: Icons.download_rounded,
                    height: 38,
                    variant: GlowButtonVariant.primary,
                    onPressed: () => UrlHelper.launchURL(resume.url),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openViewer(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.75),
      builder: (ctx) => ResumeViewerDialog(resume: resume),
    );
  }
}
