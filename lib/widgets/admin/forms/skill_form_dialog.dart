import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/skill_model.dart';
import '../../common/glow_button.dart';

/// Admin Modal to Add or Edit Skill
class SkillFormDialog extends StatefulWidget {
  final Function(SkillModel skill) onSave;

  const SkillFormDialog({super.key, required this.onSave});

  @override
  State<SkillFormDialog> createState() => _SkillFormDialogState();
}

class _SkillFormDialogState extends State<SkillFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _relatedTechController = TextEditingController();
  final TextEditingController _projectsController = TextEditingController();
  double _proficiency = 0.85;
  SkillCategory _category = SkillCategory.programming;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final List<String> related = _relatedTechController.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final List<String> projects = _projectsController.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final SkillModel skill = SkillModel(
        name: _nameController.text.trim(),
        category: _category,
        proficiency: _proficiency,
        description: _descController.text.trim(),
        relatedTech: related.isNotEmpty ? related : ['Core Knowledge'],
        usedInProjects: projects,
      );

      widget.onSave(skill);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _relatedTechController.dispose();
    _projectsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 540),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.cyan.withValues(alpha: 0.4), width: 1.5),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Add Technology / Skill', style: AppTypography.cardTitle.copyWith(fontSize: 18)),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const Divider(color: AppColors.surfaceGlassBorder),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Skill / Technology Name *'),
                      validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<SkillCategory>(
                      initialValue: _category,
                      decoration: const InputDecoration(labelText: 'Skill Category'),
                      dropdownColor: AppColors.surfaceElevated,
                      items: SkillCategory.values
                          .map((c) => DropdownMenuItem(value: c, child: Text('${c.icon} ${c.label}')))
                          .toList(),
                      onChanged: (v) => setState(() => _category = v!),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Proficiency Level:', style: AppTypography.bodySmall),
                        Text('${(_proficiency * 100).toInt()}%', style: AppTypography.codeFont(color: AppColors.cyan, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Slider(
                      value: _proficiency,
                      min: 0.1,
                      max: 1.0,
                      divisions: 18,
                      activeColor: AppColors.cyan,
                      inactiveColor: AppColors.surfaceGlass,
                      onChanged: (v) => setState(() => _proficiency = v),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descController,
                      maxLines: 2,
                      decoration: const InputDecoration(labelText: 'Scope / Technical Usage *'),
                      validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _relatedTechController,
                      decoration: const InputDecoration(labelText: 'Related Technologies (comma-separated)'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _projectsController,
                      decoration: const InputDecoration(labelText: 'Used In Projects (comma-separated)'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GlowButton(
                          text: 'Cancel',
                          variant: GlowButtonVariant.secondary,
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 12),
                        GlowButton(
                          text: 'Save Skill',
                          variant: GlowButtonVariant.primary,
                          onPressed: _submit,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
