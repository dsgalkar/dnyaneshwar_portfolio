import 'package:flutter/material.dart';
import '../../core/animations/reveal_animation.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/responsive.dart';
import '../../models/experience_model.dart';
import '../common/tech_badge.dart';

/// Flagship Experience Showcase for single demo experience highlight
class ExperienceTimeline extends StatefulWidget {
  final List<ExperienceModel> experiences;

  const ExperienceTimeline({super.key, required this.experiences});

  @override
  State<ExperienceTimeline> createState() => _ExperienceTimelineState();
}

class _ExperienceTimelineState extends State<ExperienceTimeline> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    if (widget.experiences.isEmpty) return const SizedBox.shrink();
    final exp = widget.experiences.first;
    final bool isDesktop = Responsive.isDesktop(context);

    return RevealAnimation(
      delay: const Duration(milliseconds: 150),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.all(isDesktop ? 36 : 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered ? AppColors.secondarySky.withValues(alpha: 0.4) : AppColors.surfaceGlassBorder,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppColors.secondarySky.withValues(alpha: 0.12)
                    : const Color(0xFF0F172A).withValues(alpha: 0.05),
                blurRadius: _isHovered ? 28 : 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Organization, Role, and Badges
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: AppColors.secondarySky.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.secondarySky.withValues(alpha: 0.2)),
                          ),
                          alignment: Alignment.center,
                          child: Text(exp.icon, style: const TextStyle(fontSize: 26)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exp.title,
                                style: AppTypography.cardTitle.copyWith(
                                  fontSize: isDesktop ? 22 : 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                exp.organization,
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.primaryIndigo,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Period & Role Pill
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    alignment: WrapAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.primaryIndigo.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.primaryIndigo.withValues(alpha: 0.15)),
                        ),
                        child: Text(
                          exp.period,
                          style: AppTypography.codeFont(
                            color: AppColors.primaryIndigo,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.rosePink.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          exp.roleType.toUpperCase(),
                          style: AppTypography.codeFont(
                            color: AppColors.rosePink,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Description
              Text(
                exp.description,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 24),

              // Key Impact Highlights
              Text(
                'Key Leadership & Engineering Highlights',
                style: AppTypography.codeFont(
                  color: AppColors.primaryIndigo,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              for (final highlight in exp.highlights) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4, right: 12),
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.secondarySky,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          highlight,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 20),

              // Impact Metrics Strip
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.slate50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.slate200),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCol('600+', 'Symposium Users', AppColors.primaryIndigo),
                    Container(height: 28, width: 1, color: AppColors.slate200),
                    _buildStatCol('5+', 'Technical Workshops', AppColors.secondarySky),
                    Container(height: 28, width: 1, color: AppColors.slate200),
                    _buildStatCol('40+', 'Developers Mentored', AppColors.mintGreen),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Tags
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: exp.tags.map((tag) {
                  return TechBadge(label: tag, color: AppColors.primaryIndigo);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCol(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.cardTitle.copyWith(
            fontSize: 18,
            color: color,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.codeFont(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
