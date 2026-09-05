import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/experience_model.dart';
import '../../common/glow_button.dart';

/// Admin Modal to Add Timeline Experience
class ExperienceFormDialog extends StatefulWidget {
  final Function(ExperienceModel exp) onSave;

  const ExperienceFormDialog({super.key, required this.onSave});

  @override
  State<ExperienceFormDialog> createState() => _ExperienceFormDialogState();
}

class _ExperienceFormDialogState extends State<ExperienceFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _orgController = TextEditingController();
  final TextEditingController _periodController = TextEditingController(text: '2024 — Present');
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _highlightsController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _iconController = TextEditingController(text: '💼');
  String _roleType = 'Leadership';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final List<String> highlights = _highlightsController.text
          .split('\n')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final List<String> tags = _tagsController.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final ExperienceModel exp = ExperienceModel(
        title: _titleController.text.trim(),
        organization: _orgController.text.trim(),
        period: _periodController.text.trim(),
        roleType: _roleType,
        description: _descController.text.trim(),
        highlights: highlights.isNotEmpty ? highlights : ['Key milestone contribution'],
        tags: tags.isNotEmpty ? tags : ['Engineering'],
        icon: _iconController.text.trim().isNotEmpty ? _iconController.text.trim() : '💼',
      );

      widget.onSave(exp);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _orgController.dispose();
    _periodController.dispose();
    _descController.dispose();
    _highlightsController.dispose();
    _tagsController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
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
                        Text('Add Timeline Milestone / Experience', style: AppTypography.cardTitle.copyWith(fontSize: 18)),
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
                            controller: _iconController,
                            decoration: const InputDecoration(labelText: 'Icon'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _titleController,
                            decoration: const InputDecoration(labelText: 'Role / Milestone Title *'),
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
                            controller: _orgController,
                            decoration: const InputDecoration(labelText: 'Organization / Event *'),
                            validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 140,
                          child: TextFormField(
                            controller: _periodController,
                            decoration: const InputDecoration(labelText: 'Timeframe'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: _roleType,
                      decoration: const InputDecoration(labelText: 'Role Category'),
                      dropdownColor: AppColors.surfaceElevated,
                      items: ['Leadership', 'Hackathon', 'Community', 'Academic', 'Internship', 'Open Source']
                          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (v) => setState(() => _roleType = v!),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _descController,
                      maxLines: 2,
                      decoration: const InputDecoration(labelText: 'Brief Description *'),
                      validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _highlightsController,
                      maxLines: 3,
                      decoration: const InputDecoration(labelText: 'Bullet Highlights (One per line)'),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _tagsController,
                      decoration: const InputDecoration(labelText: 'Tags (comma-separated, e.g. Flutter, Leader)'),
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
                          text: 'Save Milestone',
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
