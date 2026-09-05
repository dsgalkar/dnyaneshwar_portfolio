import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/url_helper.dart';
import '../../models/resume_model.dart';
import '../common/glass_container.dart';
import '../common/glow_button.dart';
import '../common/tech_badge.dart';

/// Full-Fidelity In-App CV Viewer with structured breakdown and Direct Download trigger
class ResumeViewerDialog extends StatelessWidget {
  final ResumeModel resume;

  const ResumeViewerDialog({super.key, required this.resume});

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
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated.withValues(alpha: 0.96),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.cyan.withValues(alpha: 0.4), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    blurRadius: 35,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Top Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 20, 20, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.description_outlined, color: Colors.black, size: 24),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(resume.title, style: AppTypography.cardTitle.copyWith(fontSize: 18)),
                                Text('${resume.roleFocus} • ${resume.fileSize}', style: AppTypography.codeFont(color: AppColors.cyan, fontSize: 12)),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),

                  const Divider(color: AppColors.surfaceGlassBorder, height: 1),

                  // CV Document Body
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Document Header Bar
                          GlassContainer(
                            padding: const EdgeInsets.all(20),
                            borderRadius: 16,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Dnyaneshwar Galkar', style: AppTypography.heroHeading(context, fontSize: 22)),
                                    const SizedBox(height: 4),
                                    Text('Computer Engineering Student & Systems Developer', style: AppTypography.codeFont(color: AppColors.cyan, fontSize: 13)),
                                    const SizedBox(height: 4),
                                    Text('Email: dnyaneshwargalkar@gmail.com | Pune, India', style: AppTypography.bodySmall),
                                  ],
                                ),
                                TechBadge(label: resume.badge, color: AppColors.emerald, isGlowing: true),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Profile Focus Synopsis
                          Text('TARGET SPECIALIZATION', style: AppTypography.codeFont(color: AppColors.cyan, fontSize: 13, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                            'Specialized technical dossier optimized for ${resume.roleFocus}. Updated: ${resume.lastUpdated}.',
                            style: AppTypography.bodyMedium,
                          ),

                          const SizedBox(height: 20),

                          // Highlights
                          Text('KEY CAREER & TECHNICAL HIGHLIGHTS', style: AppTypography.codeFont(color: AppColors.cyan, fontSize: 13, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          for (final point in resume.summaryPoints) ...[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('▹ ', style: TextStyle(color: AppColors.cyan, fontSize: 14)),
                                  Expanded(child: Text(point, style: AppTypography.bodyMedium)),
                                ],
                              ),
                            ),
                          ],

                          const SizedBox(height: 20),

                          // Education Synopsis
                          Text('FORMAL EDUCATION', style: AppTypography.codeFont(color: AppColors.cyan, fontSize: 13, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          GlassContainer(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Bachelor of Engineering in Computer Engineering', style: AppTypography.cardTitle.copyWith(fontSize: 15)),
                                const SizedBox(height: 2),
                                Text('Savitribai Phule Pune University (2023 — 2027)', style: AppTypography.codeFont(color: AppColors.cyan, fontSize: 12)),
                                const SizedBox(height: 6),
                                Text('Core Coursework: Operating Systems, Computer Networks, Data Structures & Algorithms, DBMS, Cyber Defense.', style: AppTypography.bodySmall),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Action Bar with Download Button
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Verified PDF Document (${resume.fileSize})',
                          style: AppTypography.codeFont(color: AppColors.textMuted, fontSize: 12),
                        ),
                        Row(
                          children: [
                            GlowButton(
                              text: 'Close',
                              variant: GlowButtonVariant.secondary,
                              onPressed: () => Navigator.pop(context),
                            ),
                            const SizedBox(width: 12),
                            GlowButton(
                              text: 'Download PDF Resume',
                              icon: Icons.download_rounded,
                              variant: GlowButtonVariant.primary,
                              onPressed: () => UrlHelper.launchURL(resume.url),
                            ),
                          ],
                        ),
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
