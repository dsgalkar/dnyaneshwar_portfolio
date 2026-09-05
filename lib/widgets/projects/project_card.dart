import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../models/project_model.dart';
import '../common/glass_container.dart';
import '../common/glow_button.dart';
import '../common/tech_badge.dart';
import '../common/tilt_card.dart';
import 'project_detail_dialog.dart';

/// Project Card with 3D tilt, gradient accent border, and case-study dialog launcher
class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return TiltCard(
      glowColor: AppColors.primaryIndigo,
      onTap: () => _openDetails(context),
      child: GlassContainer(
        padding: const EdgeInsets.all(24),
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
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primaryIndigo.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.primaryIndigo.withValues(alpha: 0.2)),
                      ),
                      alignment: Alignment.center,
                      child: Text(project.iconSymbol, style: const TextStyle(fontSize: 24)),
                    ),
                    if (project.isFeatured)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'FEATURED',
                          style: AppTypography.codeFont(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 18),

                // Title
                Text(
                  project.title,
                  style: AppTypography.cardTitle.copyWith(fontSize: 20),
                ),

                const SizedBox(height: 6),

                // Category Tag
                Text(
                  project.category,
                  style: AppTypography.codeFont(
                    color: AppColors.primaryIndigo,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),

                // Short Description
                Text(
                  project.tagline,
                  style: AppTypography.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 18),

                // Tech Badges
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: project.technologies.take(4).map((tech) {
                    return TechBadge(label: tech, color: AppColors.primaryIndigo);
                  }).toList(),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Action Button
            GlowButton(
              text: 'View Case Study',
              icon: Icons.auto_awesome_outlined,
              height: 40,
              width: double.infinity,
              variant: GlowButtonVariant.outline,
              onPressed: () => _openDetails(context),
            ),
          ],
        ),
      ),
    );
  }

  void _openDetails(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.35),
      builder: (context) => ProjectDetailDialog(project: project),
    );
  }
}
