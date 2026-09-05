import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../state/portfolio_state_manager.dart';
import '../common/glass_container.dart';
import '../common/glow_button.dart';
import '../common/tech_badge.dart';
import 'forms/project_form_dialog.dart';
import 'forms/achievement_form_dialog.dart';
import 'forms/experience_form_dialog.dart';
import 'forms/skill_form_dialog.dart';
import 'forms/resume_form_dialog.dart';

/// Full-Scale Interactive Cyber Control Panel for Portfolio Administration
class AdminDashboardModal extends StatefulWidget {
  final PortfolioStateManager stateManager;

  const AdminDashboardModal({super.key, required this.stateManager});

  @override
  State<AdminDashboardModal> createState() => _AdminDashboardModalState();
}

class _AdminDashboardModalState extends State<AdminDashboardModal> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1050, maxHeight: 850),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated.withValues(alpha: 0.96),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.cyan.withValues(alpha: 0.5), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyan.withValues(alpha: 0.2),
                    blurRadius: 40,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: AnimatedBuilder(
                animation: widget.stateManager,
                builder: (context, child) {
                  return Column(
                    children: [
                      // Header with Admin Mode Pill & Close
                      Padding(
                        padding: const EdgeInsets.fromLTRB(28, 20, 20, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    gradient: AppColors.primaryGradient,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.tune_rounded, color: Colors.black, size: 22),
                                ),
                                const SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Portfolio Control Center', style: AppTypography.cardTitle.copyWith(fontSize: 20)),
                                        const SizedBox(width: 10),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.emerald.withValues(alpha: 0.18),
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(color: AppColors.emerald.withValues(alpha: 0.4)),
                                          ),
                                          child: Text('LIVE CRUD SYNC', style: AppTypography.codeFont(color: AppColors.emerald, fontSize: 10, fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    Text('Add, edit, or remove live parameters across your portfolio', style: AppTypography.bodySmall),
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

                      // Tabs Bar
                      TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        indicatorColor: AppColors.cyan,
                        indicatorWeight: 3,
                        labelColor: AppColors.cyan,
                        unselectedLabelColor: AppColors.textSecondary,
                        tabs: [
                          Tab(text: '🚀 Projects (${widget.stateManager.projects.length})'),
                          Tab(text: '📜 Certifications (${widget.stateManager.achievements.length})'),
                          Tab(text: '💼 Timeline (${widget.stateManager.experiences.length})'),
                          Tab(text: '⚡ Skills (${widget.stateManager.skills.length})'),
                          Tab(text: '📄 Resumes (${widget.stateManager.resumes.length})'),
                          Tab(text: '👤 Bio & Profile'),
                        ],
                      ),

                      const Divider(color: AppColors.surfaceGlassBorder, height: 1),

                      // Tab Views
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildProjectsTab(context),
                            _buildAchievementsTab(context),
                            _buildExperiencesTab(context),
                            _buildSkillsTab(context),
                            _buildResumesTab(context),
                            _buildProfileTab(context),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- PROJECTS TAB ---
  Widget _buildProjectsTab(BuildContext context) {
    final projects = widget.stateManager.projects;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Active Project Case Studies', style: AppTypography.cardTitle.copyWith(fontSize: 16)),
              GlowButton(
                text: 'Add New Project',
                icon: Icons.add_rounded,
                height: 38,
                variant: GlowButtonVariant.primary,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => ProjectFormDialog(
                      onSave: (proj) => widget.stateManager.addProject(proj),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, i) {
                final p = projects[i];
                return GlassContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Text(p.iconSymbol, style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(p.title, style: AppTypography.cardTitle.copyWith(fontSize: 16)),
                                const SizedBox(width: 8),
                                TechBadge(label: p.category, color: AppColors.cyan),
                                if (p.isFeatured) ...[
                                  const SizedBox(width: 6),
                                  const TechBadge(label: 'FEATURED', color: AppColors.warning),
                                ],
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(p.tagline, style: AppTypography.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: AppColors.cyan, size: 20),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => ProjectFormDialog(
                              existingProject: p,
                              onSave: (updated) => widget.stateManager.updateProject(p.id, updated),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 20),
                        onPressed: () => widget.stateManager.deleteProject(p.id),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- CERTIFICATIONS & ACHIEVEMENTS TAB ---
  Widget _buildAchievementsTab(BuildContext context) {
    final achievements = widget.stateManager.achievements;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Certifications, Honors & Hackathon Honors', style: AppTypography.cardTitle.copyWith(fontSize: 16)),
              GlowButton(
                text: 'Add Credential',
                icon: Icons.add_rounded,
                height: 38,
                variant: GlowButtonVariant.primary,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AchievementFormDialog(
                      onSave: (ach) => widget.stateManager.addAchievement(ach),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: achievements.length,
              itemBuilder: (context, i) {
                final a = achievements[i];
                return GlassContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Text(a.badgeIcon, style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(a.title, style: AppTypography.cardTitle.copyWith(fontSize: 16)),
                            Text('${a.issuer} • ${a.date}', style: AppTypography.codeFont(color: AppColors.cyan, fontSize: 12)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 20),
                        onPressed: () => widget.stateManager.deleteAchievement(i),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- TIMELINE EXPERIENCES TAB ---
  Widget _buildExperiencesTab(BuildContext context) {
    final experiences = widget.stateManager.experiences;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Career, Club & Community Milestones', style: AppTypography.cardTitle.copyWith(fontSize: 16)),
              GlowButton(
                text: 'Add Milestone',
                icon: Icons.add_rounded,
                height: 38,
                variant: GlowButtonVariant.primary,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => ExperienceFormDialog(
                      onSave: (exp) => widget.stateManager.addExperience(exp),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: experiences.length,
              itemBuilder: (context, i) {
                final e = experiences[i];
                return GlassContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Text(e.icon, style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.title, style: AppTypography.cardTitle.copyWith(fontSize: 16)),
                            Text('${e.organization} (${e.period})', style: AppTypography.codeFont(color: AppColors.cyan, fontSize: 12)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 20),
                        onPressed: () => widget.stateManager.deleteExperience(i),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- SKILLS TAB ---
  Widget _buildSkillsTab(BuildContext context) {
    final skills = widget.stateManager.skills;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Skills Arsenal & Tech Nodes', style: AppTypography.cardTitle.copyWith(fontSize: 16)),
              GlowButton(
                text: 'Add Skill',
                icon: Icons.add_rounded,
                height: 38,
                variant: GlowButtonVariant.primary,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => SkillFormDialog(
                      onSave: (skill) => widget.stateManager.addSkill(skill),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: skills.length,
              itemBuilder: (context, i) {
                final s = skills[i];
                return GlassContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Text(s.category.icon, style: const TextStyle(fontSize: 18)),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text('${s.name} (${(s.proficiency * 100).toInt()}%)', style: AppTypography.cardTitle.copyWith(fontSize: 15)),
                      ),
                      Text(s.category.label, style: AppTypography.codeFont(color: AppColors.textMuted, fontSize: 11)),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 18),
                        onPressed: () => widget.stateManager.deleteSkill(s.name),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- RESUMES TAB ---
  Widget _buildResumesTab(BuildContext context) {
    final resumes = widget.stateManager.resumes;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tailored Resume Documents', style: AppTypography.cardTitle.copyWith(fontSize: 16)),
              GlowButton(
                text: 'Add Resume Variant',
                icon: Icons.add_rounded,
                height: 38,
                variant: GlowButtonVariant.primary,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => ResumeFormDialog(
                      onSave: (res) => widget.stateManager.addResume(res),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: resumes.length,
              itemBuilder: (context, i) {
                final r = resumes[i];
                return GlassContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.description_outlined, color: AppColors.cyan, size: 24),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(r.title, style: AppTypography.cardTitle.copyWith(fontSize: 15)),
                                if (r.isPrimary) ...[
                                  const SizedBox(width: 8),
                                  const TechBadge(label: 'PRIMARY', color: AppColors.emerald),
                                ],
                              ],
                            ),
                            Text('${r.roleFocus} • ${r.fileSize}', style: AppTypography.codeFont(color: AppColors.textMuted, fontSize: 11)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 20),
                        onPressed: () => widget.stateManager.deleteResume(r.id),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- BIO & PROFILE TAB ---
  Widget _buildProfileTab(BuildContext context) {
    final TextEditingController bio1Ctrl = TextEditingController(text: widget.stateManager.bio1);
    final TextEditingController bio2Ctrl = TextEditingController(text: widget.stateManager.bio2);
    final TextEditingController taglineCtrl = TextEditingController(text: widget.stateManager.tagline);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Edit Bio & Philosophy', style: AppTypography.cardTitle.copyWith(fontSize: 16)),
          const SizedBox(height: 14),
          TextFormField(
            controller: taglineCtrl,
            decoration: const InputDecoration(labelText: 'Hero Tagline Statement'),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: bio1Ctrl,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Bio Paragraph 1 (Background)'),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: bio2Ctrl,
            maxLines: 3,
            decoration: const InputDecoration(labelText: 'Bio Paragraph 2 (Community & Engineering)'),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: GlowButton(
              text: 'Save Profile Changes',
              variant: GlowButtonVariant.primary,
              onPressed: () {
                widget.stateManager.updateBio(
                  bio1: bio1Ctrl.text.trim(),
                  bio2: bio2Ctrl.text.trim(),
                  tagline: taglineCtrl.text.trim(),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.surfaceElevated,
                    content: Text('Profile bio parameters updated successfully! ✨', style: TextStyle(color: AppColors.cyan)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
