import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/responsive.dart';
import '../../models/resume_model.dart';
import '../common/glass_container.dart';
import 'resume_card.dart';

/// Multi-Resume Hub with multiple tailored files, in-app viewer, and direct download buttons
class ResumeSection extends StatelessWidget {
  final List<ResumeModel> resumes;
  final VoidCallback? onAddResume;
  final bool isAdmin;

  const ResumeSection({
    super.key,
    required this.resumes,
    this.onAddResume,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final bool isTablet = Responsive.isTablet(context);

    final int crossAxis = isDesktop ? 3 : (isTablet ? 2 : 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Info Banner
        GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          borderRadius: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.folder_shared_outlined, color: AppColors.cyan, size: 24),
                  const SizedBox(width: 12),
                  Text(
                    'Tailored Resume Dossiers (${resumes.length} Formats Available)',
                    style: AppTypography.cardTitle.copyWith(fontSize: 16),
                  ),
                ],
              ),
              if (isAdmin && onAddResume != null)
                IconButton(
                  icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.cyan),
                  tooltip: 'Add Resume Variant',
                  onPressed: onAddResume,
                ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Grid of Multiple Resumes
        LayoutBuilder(
          builder: (context, constraints) {
            final double cardWidth = (constraints.maxWidth - (crossAxis - 1) * 20) / crossAxis;

            return Wrap(
              spacing: 20,
              runSpacing: 20,
              children: resumes.map((resume) {
                return SizedBox(
                  width: cardWidth,
                  child: ResumeCard(resume: resume),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
