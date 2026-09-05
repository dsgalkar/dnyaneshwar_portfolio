import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/achievement_model.dart';
import '../../common/glow_button.dart';

/// Admin Modal to Add or Edit Certifications & Achievements
class AchievementFormDialog extends StatefulWidget {
  final AchievementModel? existingAchievement;
  final Function(AchievementModel achievement) onSave;

  const AchievementFormDialog({
    super.key,
    this.existingAchievement,
    required this.onSave,
  });

  @override
  State<AchievementFormDialog> createState() => _AchievementFormDialogState();
}

class _AchievementFormDialogState extends State<AchievementFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _issuerController;
  late TextEditingController _dateController;
  late TextEditingController _descController;
  late TextEditingController _skillsController;
  late TextEditingController _badgeIconController;
  late TextEditingController _credentialUrlController;
  String _category = 'Certification';

  @override
  void initState() {
    super.initState();
    final a = widget.existingAchievement;
    _titleController = TextEditingController(text: a?.title ?? '');
    _issuerController = TextEditingController(text: a?.issuer ?? '');
    _dateController = TextEditingController(text: a?.date ?? '${DateTime.now().year}');
    _descController = TextEditingController(text: a?.description ?? '');
    _skillsController = TextEditingController(text: a?.skillsGained.join(', ') ?? '');
    _badgeIconController = TextEditingController(text: a?.badgeIcon ?? '🏆');
    _credentialUrlController = TextEditingController(text: a?.credentialUrl ?? '');
    if (a != null) {
      _category = a.category;
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final List<String> skills = _skillsController.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final AchievementModel ach = AchievementModel(
        title: _titleController.text.trim(),
        issuer: _issuerController.text.trim(),
        date: _dateController.text.trim(),
        description: _descController.text.trim(),
        category: _category,
        badgeIcon: _badgeIconController.text.trim().isNotEmpty ? _badgeIconController.text.trim() : '🏆',
        credentialUrl: _credentialUrlController.text.trim().isNotEmpty ? _credentialUrlController.text.trim() : null,
        skillsGained: skills.isNotEmpty ? skills : ['Engineering Excellence'],
      );

      widget.onSave(ach);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _issuerController.dispose();
    _dateController.dispose();
    _descController.dispose();
    _skillsController.dispose();
    _badgeIconController.dispose();
    _credentialUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 580),
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
                        Text('Add Certification / Achievement', style: AppTypography.cardTitle.copyWith(fontSize: 18)),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const Divider(color: AppColors.surfaceGlassBorder),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        SizedBox(
                          width: 70,
                          child: TextFormField(
                            controller: _badgeIconController,
                            decoration: const InputDecoration(labelText: 'Icon'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _titleController,
                            decoration: const InputDecoration(labelText: 'Credential Title *'),
                            validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _issuerController,
                            decoration: const InputDecoration(labelText: 'Issuer / Organization *'),
                            validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 120,
                          child: TextFormField(
                            controller: _dateController,
                            decoration: const InputDecoration(labelText: 'Year/Date'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _category,
                      decoration: const InputDecoration(labelText: 'Category'),
                      dropdownColor: AppColors.surfaceElevated,
                      items: ['Certification', 'Competition', 'Hackathon', 'Academic', 'Community']
                          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (v) => setState(() => _category = v!),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descController,
                      maxLines: 2,
                      decoration: const InputDecoration(labelText: 'Description / Scope'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _skillsController,
                      decoration: const InputDecoration(labelText: 'Skills Gained (comma-separated)'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _credentialUrlController,
                      decoration: const InputDecoration(labelText: 'Verification / Certificate URL (optional)'),
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
                          text: 'Save Credential',
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
