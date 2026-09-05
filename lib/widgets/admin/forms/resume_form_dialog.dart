import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../models/resume_model.dart';
import '../../common/glow_button.dart';

/// Admin Modal to Add or Edit Tailored Resume files
class ResumeFormDialog extends StatefulWidget {
  final Function(ResumeModel resume) onSave;

  const ResumeFormDialog({super.key, required this.onSave});

  @override
  State<ResumeFormDialog> createState() => _ResumeFormDialogState();
}

class _ResumeFormDialogState extends State<ResumeFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _focusController = TextEditingController();
  final TextEditingController _dateController = TextEditingController(text: 'JAN 2025');
  final TextEditingController _urlController = TextEditingController(text: 'https://raw.githubusercontent.com/dnyaneshwargalkar/resume/main/resume.pdf');
  final TextEditingController _sizeController = TextEditingController(text: '160 KB');
  final TextEditingController _badgeController = TextEditingController(text: 'TAILORED');
  final TextEditingController _summaryController = TextEditingController();
  bool _isPrimary = false;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final List<String> summaries = _summaryController.text
          .split('\n')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final ResumeModel resume = ResumeModel(
        id: 'resume-${DateTime.now().millisecondsSinceEpoch}',
        title: _titleController.text.trim(),
        roleFocus: _focusController.text.trim(),
        lastUpdated: _dateController.text.trim(),
        url: _urlController.text.trim(),
        fileSize: _sizeController.text.trim(),
        isPrimary: _isPrimary,
        badge: _badgeController.text.trim().isNotEmpty ? _badgeController.text.trim() : 'PDF',
        summaryPoints: summaries.isNotEmpty ? summaries : ['Tailored resume profile for engineering roles'],
      );

      widget.onSave(resume);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _focusController.dispose();
    _dateController.dispose();
    _urlController.dispose();
    _sizeController.dispose();
    _badgeController.dispose();
    _summaryController.dispose();
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
                        Text('Add Tailored Resume Document', style: AppTypography.cardTitle.copyWith(fontSize: 18)),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const Divider(color: AppColors.surfaceGlassBorder),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Resume Title * (e.g. Flutter Specialist CV)'),
                      validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _focusController,
                            decoration: const InputDecoration(labelText: 'Target Focus (e.g. Mobile / Systems) *'),
                            validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 110,
                          child: TextFormField(
                            controller: _badgeController,
                            decoration: const InputDecoration(labelText: 'Badge Tag'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _urlController,
                            decoration: const InputDecoration(labelText: 'Download / Hosted PDF URL *'),
                            validator: (v) => v!.trim().isEmpty ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                            controller: _sizeController,
                            decoration: const InputDecoration(labelText: 'File Size'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _summaryController,
                      maxLines: 3,
                      decoration: const InputDecoration(labelText: 'Key Highlights Summary (One bullet per line)'),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Checkbox(
                          value: _isPrimary,
                          activeColor: AppColors.cyan,
                          onChanged: (v) => setState(() => _isPrimary = v!),
                        ),
                        const Text('Set as Primary Default Resume', style: TextStyle(color: Colors.white)),
                      ],
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
                          text: 'Save Resume Document',
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
