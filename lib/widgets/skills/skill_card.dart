import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../models/skill_model.dart';
import '../common/glass_container.dart';
import '../common/tech_badge.dart';
import '../common/tilt_card.dart';

/// Interactive Skill Card with dynamic proficiency meter & project links
class SkillCard extends StatelessWidget {
  final SkillModel skill;
  final bool isSelected;
  final VoidCallback onTap;

  const SkillCard({
    super.key,
    required this.skill,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color categoryColor = _getCategoryColor(skill.category);

    return TiltCard(
      glowColor: categoryColor,
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(20),
        borderColor: isSelected ? categoryColor : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Header: Name & Percent
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    skill.name,
                    style: AppTypography.cardTitle.copyWith(fontSize: 18),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: categoryColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${(skill.proficiency * 100).toInt()}%',
                    style: AppTypography.codeFont(
                      color: categoryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Animated Proficiency Bar
            Stack(
              children: [
                Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceElevated,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: skill.proficiency,
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [categoryColor.withValues(alpha: 0.6), categoryColor],
                      ),
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: categoryColor.withValues(alpha: 0.6),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Description
            Text(
              skill.description,
              style: AppTypography.bodySmall,
            ),

            const SizedBox(height: 16),

            // Related Tech Badges
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: skill.relatedTech.map((tech) {
                return TechBadge(label: tech, color: categoryColor);
              }).toList(),
            ),

            if (skill.usedInProjects.isNotEmpty) ...[
              const SizedBox(height: 14),
              const Divider(color: AppColors.surfaceGlassBorder, height: 1),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.layers_outlined, size: 14, color: AppColors.textMuted),
                  const SizedBox(width: 6),
                  Text(
                    'Key Projects: ${skill.usedInProjects.join(', ')}',
                    style: AppTypography.codeFont(color: AppColors.textMuted, fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(SkillCategory category) {
    switch (category) {
      case SkillCategory.programming:
        return AppColors.cyan;
      case SkillCategory.appDev:
        return AppColors.blue;
      case SkillCategory.web:
        return AppColors.electricViolet;
      case SkillCategory.cybersecurity:
        return AppColors.neonPink;
      case SkillCategory.data:
        return AppColors.emerald;
      case SkillCategory.tools:
        return AppColors.warning;
    }
  }
}
