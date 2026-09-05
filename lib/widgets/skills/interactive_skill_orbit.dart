import 'package:flutter/material.dart';
import '../../core/utils/responsive.dart';
import '../../core/animations/reveal_animation.dart';
import '../../models/skill_model.dart';
import 'skill_card.dart';
import 'skill_category_selector.dart';

/// Full Interactive Skills Section layout with filtering and live reactive skills
class SkillsSectionView extends StatefulWidget {
  final List<SkillModel> skills;

  const SkillsSectionView({super.key, required this.skills});

  @override
  State<SkillsSectionView> createState() => _SkillsSectionViewState();
}

class _SkillsSectionViewState extends State<SkillsSectionView> {
  SkillCategory _selectedCategory = SkillCategory.programming;
  String? _selectedSkillName;

  @override
  Widget build(BuildContext context) {
    final List<SkillModel> filteredSkills = widget.skills
        .where((s) => s.category == _selectedCategory)
        .toList();

    final bool isDesktop = Responsive.isDesktop(context);
    final bool isTablet = Responsive.isTablet(context);

    int crossAxisCount = 1;
    if (isDesktop) {
      crossAxisCount = 3;
    } else if (isTablet) {
      crossAxisCount = 2;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Pills
        RevealAnimation(
          delay: const Duration(milliseconds: 100),
          child: SkillCategorySelector(
            selectedCategory: _selectedCategory,
            onCategoryChanged: (category) {
              setState(() {
                _selectedCategory = category;
                _selectedSkillName = null;
              });
            },
          ),
        ),

        const SizedBox(height: 24),

        // Skills Grid
        LayoutBuilder(
          builder: (context, constraints) {
            final double itemWidth = (constraints.maxWidth - (crossAxisCount - 1) * 16) / crossAxisCount;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: filteredSkills.map((skill) {
                return SizedBox(
                  width: itemWidth,
                  child: RevealAnimation(
                    direction: RevealDirection.scale,
                    delay: Duration(milliseconds: 50 * filteredSkills.indexOf(skill)),
                    child: SkillCard(
                      skill: skill,
                      isSelected: _selectedSkillName == skill.name,
                      onTap: () {
                        setState(() {
                          _selectedSkillName = skill.name;
                        });
                      },
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
