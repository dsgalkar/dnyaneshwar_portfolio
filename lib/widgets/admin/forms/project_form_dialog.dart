import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/project_model.dart';
import '../../common/glow_button.dart';

/// Admin Modal to Add or Edit a Project in Real Time
class ProjectFormDialog extends StatefulWidget {
  final ProjectModel? existingProject;
  final Function(ProjectModel project) onSave;

  const ProjectFormDialog({
    super.key,
    this.existingProject,
    required this.onSave,
  });

  @override
  State<ProjectFormDialog> createState() => _ProjectFormDialogState();
}

class _ProjectFormDialogState extends State<ProjectFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _taglineController;
  late TextEditingController _descController;
  late TextEditingController _problemController;
  late TextEditingController _solutionController;
  late TextEditingController _featuresController;
  late TextEditingController _techController;
  late TextEditingController _architectureController;
  late TextEditingController _learningsController;
  late TextEditingController _githubController;
  late TextEditingController _demoController;
  late TextEditingController _iconController;
  String _category = 'Mobile';
  bool _isFeatured = true;

  @override
  void initState() {
    super.initState();
    final p = widget.existingProject;
    _titleController = TextEditingController(text: p?.title ?? '');
    _taglineController = TextEditingController(text: p?.tagline ?? '');
    _descController = TextEditingController(text: p?.description ?? '');
    _problemController = TextEditingController(text: p?.problem ?? '');
    _solutionController = TextEditingController(text: p?.solution ?? '');
    _featuresController = TextEditingController(text: p?.features.join('\n') ?? '');
    _techController = TextEditingController(text: p?.technologies.join(', ') ?? '');
    _architectureController = TextEditingController(text: p?.architecture ?? '');
    _learningsController = TextEditingController(text: p?.learnings ?? '');
    _githubController = TextEditingController(text: p?.githubUrl ?? '');
    _demoController = TextEditingController(text: p?.liveDemoUrl ?? '');
    _iconController = TextEditingController(text: p?.iconSymbol ?? '🚀');
    if (p != null) {
      _category = p.category;
      _isFeatured = p.isFeatured;
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final List<String> featuresList = _featuresController.text
          .split('\n')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final List<String> techList = _techController.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final ProjectModel project = ProjectModel(
        id: widget.existingProject?.id ?? 'proj-${DateTime.now().millisecondsSinceEpoch}',
        title: _titleController.text.trim(),
        tagline: _taglineController.text.trim(),
        description: _descController.text.trim(),
        problem: _problemController.text.trim(),
        solution: _solutionController.text.trim(),
        features: featuresList.isNotEmpty ? featuresList : ['High-performance system architecture'],
        technologies: techList.isNotEmpty ? techList : ['Flutter', 'Dart'],
        architecture: _architectureController.text.trim().isNotEmpty
            ? _architectureController.text.trim()
            : 'Modular Clean Architecture pattern',
        challenges: 'Scalability optimization',
        learnings: _learningsController.text.trim().isNotEmpty
            ? _learningsController.text.trim()
            : 'Advanced reactive state management',
        githubUrl: _githubController.text.trim().isNotEmpty ? _githubController.text.trim() : null,
        liveDemoUrl: _demoController.text.trim().isNotEmpty ? _demoController.text.trim() : null,
        category: _category,
        isFeatured: _isFeatured,
        iconSymbol: _iconController.text.trim().isNotEmpty ? _iconController.text.trim() : '🚀',
      );

      widget.onSave(project);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _taglineController.dispose();
    _descController.dispose();
    _problemController.dispose();
    _solutionController.dispose();
    _featuresController.dispose();
    _techController.dispose();
    _architectureController.dispose();
    _learningsController.dispose();
    _githubController.dispose();
    _demoController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700, maxHeight: 780),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.existingProject != null ? 'Edit Project' : 'Add New Project Case Study',
                          style: AppTypography.cardTitle.copyWith(fontSize: 20),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const Divider(color: AppColors.surfaceGlassBorder),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: TextFormField(
                                  controller: _iconController,
                                  decoration: const InputDecoration(labelText: 'Icon/Emoji'),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: TextFormField(
                                  controller: _titleController,
                                  decoration: const InputDecoration(labelText: 'Project Title *'),
                                  validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _taglineController,
                            decoration: const InputDecoration(labelText: 'Short Tagline *'),
                            validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  initialValue: _category,
                                  decoration: const InputDecoration(labelText: 'Category'),
                                  dropdownColor: AppColors.surfaceElevated,
                                  items: ['Mobile', 'Cybersecurity', 'AI / Data', 'Full Stack']
                                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                                      .toList(),
                                  onChanged: (v) => setState(() => _category = v!),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Row(
                                children: [
                                  Checkbox(
                                    value: _isFeatured,
                                    activeColor: AppColors.cyan,
                                    onChanged: (v) => setState(() => _isFeatured = v!),
                                  ),
                                  const Text('Featured', style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _descController,
                            maxLines: 3,
                            decoration: const InputDecoration(labelText: 'Detailed Description *'),
                            validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _techController,
                            decoration: const InputDecoration(labelText: 'Technologies (Comma separated, e.g. Flutter, Dart, Firebase)'),
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _problemController,
                            maxLines: 2,
                            decoration: const InputDecoration(labelText: 'Problem Statement'),
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _solutionController,
                            maxLines: 2,
                            decoration: const InputDecoration(labelText: 'Engineered Solution'),
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _featuresController,
                            maxLines: 3,
                            decoration: const InputDecoration(labelText: 'Key Features (One per line)'),
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _architectureController,
                            decoration: const InputDecoration(labelText: 'Architecture Notes'),
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _learningsController,
                            decoration: const InputDecoration(labelText: 'Key Learnings'),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _githubController,
                                  decoration: const InputDecoration(labelText: 'GitHub Repository URL'),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: TextFormField(
                                  controller: _demoController,
                                  decoration: const InputDecoration(labelText: 'Live Demo URL'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GlowButton(
                          text: 'Cancel',
                          variant: GlowButtonVariant.secondary,
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 14),
                        GlowButton(
                          text: 'Save Project',
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
