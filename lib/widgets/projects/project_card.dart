import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/url_helper.dart';
import '../../models/project_model.dart';
import '../common/glow_button.dart';
import '../common/tech_badge.dart';
import 'project_detail_dialog.dart';

/// Flagship Project Showcase Card designed for the demo highlight
class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  void _openDetails(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: const Color(0xFF0F172A).withValues(alpha: 0.35),
      builder: (context) => ProjectDetailDialog(project: widget.project),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    final bool useWideSplit = screenW >= 1020;
    final bool isMobile = Responsive.isMobile(context);
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered ? AppColors.primaryIndigo.withValues(alpha: 0.4) : AppColors.surfaceGlassBorder,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppColors.primaryIndigo.withValues(alpha: 0.12)
                  : const Color(0xFF0F172A).withValues(alpha: 0.05),
              blurRadius: _isHovered ? 28 : 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: EdgeInsets.all(useWideSplit ? 36 : (isMobile ? 20 : 28)),
        child: useWideSplit
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: _buildProjectInfo(context, project),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    flex: 5,
                    child: _buildTelemetryPreview(context, project),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTelemetryPreview(context, project),
                  const SizedBox(height: 28),
                  _buildProjectInfo(context, project),
                ],
              ),
      ),
    );
  }

  Widget _buildProjectInfo(BuildContext context, ProjectModel project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Category & Featured Pill Row
        Wrap(
          spacing: 10,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.primaryIndigo.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primaryIndigo.withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🛡️', style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 6),
                  Text(
                    project.category.toUpperCase(),
                    style: AppTypography.codeFont(
                      color: AppColors.primaryIndigo,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'FLAGSHIP DEMO BUILD',
                style: AppTypography.codeFont(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        // Project Title
        Text(
          project.title,
          style: AppTypography.cardTitle.copyWith(fontSize: 26),
        ),

        const SizedBox(height: 10),

        // Tagline & Narrative
        Text(
          project.tagline,
          style: AppTypography.bodyLarge.copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 18),

        // Key Bullet Highlights
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHighlightItem('Real-time ARP spoofing & MITM attack detection engine'),
            _buildHighlightItem('On-device port scanner & network risk assessment'),
            _buildHighlightItem('Isolated background processing with zero battery drain'),
          ],
        ),

        const SizedBox(height: 22),

        // Tech Badges
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.technologies.map((t) {
            return TechBadge(label: t, color: AppColors.primaryIndigo);
          }).toList(),
        ),

        const SizedBox(height: 28),

        // Action Buttons
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            GlowButton(
              text: 'View Full Case Study',
              icon: Icons.auto_awesome_rounded,
              variant: GlowButtonVariant.primary,
              height: 44,
              onPressed: () => _openDetails(context),
            ),
            if (project.githubUrl != null)
              GlowButton(
                text: 'GitHub Repository',
                icon: Icons.code_rounded,
                variant: GlowButtonVariant.secondary,
                height: 44,
                onPressed: () => UrlHelper.launchURL(project.githubUrl!),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildHighlightItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, right: 10),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.mintGreen,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTelemetryPreview(BuildContext context, ProjectModel project) {
    return GestureDetector(
      onTap: () => _openDetails(context),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.slate50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.slate200, width: 1.2),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: AppColors.mintGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'ACTIVE DEFENSE',
                      style: AppTypography.codeFont(
                        color: AppColors.mintGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.slate200),
                  ),
                  child: Text(
                    'LIVE TELEMETRY',
                    style: AppTypography.codeFont(
                      color: AppColors.textMuted,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Diagnostic Tiles
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    title: 'System Status',
                    value: 'Protected',
                    valueColor: AppColors.mintGreen,
                    icon: Icons.verified_user_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricTile(
                    title: 'Threats',
                    value: '0 Detected',
                    valueColor: AppColors.primaryIndigo,
                    icon: Icons.shield_rounded,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    title: 'Packets',
                    value: '48,290 /s',
                    valueColor: AppColors.secondarySky,
                    icon: Icons.graphic_eq_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricTile(
                    title: 'Interface',
                    value: 'wlan0 • 24ms',
                    valueColor: AppColors.textPrimary,
                    icon: Icons.wifi_rounded,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Deep Dive Prompt Banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryIndigo.withValues(alpha: 0.15)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Tap to inspect architecture & case study',
                      style: AppTypography.codeFont(
                        color: AppColors.primaryIndigo,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: AppColors.primaryIndigo,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile({
    required String title,
    required String value,
    required Color valueColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, size: 13, color: AppColors.textMuted),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.codeFont(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: AppTypography.cardTitle.copyWith(
              fontSize: 13,
              color: valueColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
