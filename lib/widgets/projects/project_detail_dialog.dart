import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/url_helper.dart';
import '../../models/project_model.dart';
import '../common/glass_container.dart';
import '../common/glow_button.dart';
import '../common/tech_badge.dart';

/// Full-Fidelity Deep-Dive Project Modal Case Study
class ProjectDetailDialog extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailDialog({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 820, maxHeight: 850),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.98),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.slate200, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.slate900.withValues(alpha: 0.12),
                    blurRadius: 40,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Modal Top Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 24, 20, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.primaryIndigo.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.primaryIndigo.withValues(alpha: 0.2)),
                              ),
                              alignment: Alignment.center,
                              child: Text(project.iconSymbol, style: const TextStyle(fontSize: 22)),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(project.title, style: AppTypography.cardTitle.copyWith(fontSize: 20)),
                                Text(project.category, style: AppTypography.codeFont(color: AppColors.primaryIndigo, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.slate100,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(color: AppColors.slate200, height: 1),

                  // Scrollable Body Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tagline & Overview
                          Text('Overview', style: AppTypography.codeFont(color: AppColors.primaryIndigo, fontSize: 14, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          Text(project.description, style: AppTypography.bodyLarge),

                          const SizedBox(height: 24),

                          // Tech Stack Badges
                          Text('Tech Stack & Libraries', style: AppTypography.codeFont(color: AppColors.primaryIndigo, fontSize: 14, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: project.technologies.map((t) {
                              return TechBadge(label: t, color: AppColors.primaryIndigo, isGlowing: false);
                            }).toList(),
                          ),

                          const SizedBox(height: 28),

                          // Problem & Solution Split Cards
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: GlassContainer(
                                  padding: const EdgeInsets.all(16),
                                  color: AppColors.amber.withValues(alpha: 0.05),
                                  borderColor: AppColors.amber.withValues(alpha: 0.4),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.error_outline_rounded, color: AppColors.amber, size: 18),
                                          const SizedBox(width: 8),
                                          Text('The Problem', style: AppTypography.cardTitle.copyWith(fontSize: 15, color: AppColors.amber)),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(project.problem, style: AppTypography.bodySmall),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: GlassContainer(
                                  padding: const EdgeInsets.all(16),
                                  color: AppColors.mintGreen.withValues(alpha: 0.05),
                                  borderColor: AppColors.mintGreen.withValues(alpha: 0.4),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.check_circle_outline_rounded, color: AppColors.mintGreen, size: 18),
                                          const SizedBox(width: 8),
                                          Text('The Solution', style: AppTypography.cardTitle.copyWith(fontSize: 15, color: AppColors.mintGreen)),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(project.solution, style: AppTypography.bodySmall),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 28),

                          // Key Features
                          Text('Key Architectural Features', style: AppTypography.codeFont(color: AppColors.primaryIndigo, fontSize: 14, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 10),
                          for (final feature in project.features) ...[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('⚡ ', style: TextStyle(fontSize: 12)),
                                  Expanded(
                                    child: Text(feature, style: AppTypography.bodyMedium),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          const SizedBox(height: 24),

                          // System Architecture & Engineering Takeaways
                          GlassContainer(
                            padding: const EdgeInsets.all(18),
                            color: AppColors.slate50,
                            borderColor: AppColors.slate200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('System Architecture:', style: AppTypography.codeFont(color: AppColors.primaryIndigo, fontSize: 13, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 4),
                                Text(project.architecture, style: AppTypography.bodySmall),
                                const SizedBox(height: 12),
                                Text('Key Engineering Learnings:', style: AppTypography.codeFont(color: AppColors.secondarySky, fontSize: 13, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 4),
                                Text(project.learnings, style: AppTypography.bodySmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Action Buttons
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (project.githubUrl != null) ...[
                          GlowButton(
                            text: 'View GitHub Code',
                            icon: Icons.code_rounded,
                            variant: GlowButtonVariant.secondary,
                            onPressed: () => UrlHelper.launchURL(project.githubUrl!),
                          ),
                          const SizedBox(width: 12),
                        ],
                        if (project.liveDemoUrl != null) ...[
                          GlowButton(
                            text: 'Live Demo',
                            icon: Icons.open_in_new_rounded,
                            variant: GlowButtonVariant.primary,
                            onPressed: () => UrlHelper.launchURL(project.liveDemoUrl!),
                          ),
                        ],
                      ],
                    ),
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
