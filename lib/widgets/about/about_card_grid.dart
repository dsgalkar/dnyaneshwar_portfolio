import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/animations/reveal_animation.dart';
import '../../core/utils/responsive.dart';
import '../../data/portfolio_data.dart';
import '../common/glass_container.dart';
import '../common/tech_badge.dart';
import '../common/tilt_card.dart';

/// Interactive About Cards: Education, Engineering Mindset, and Learning Radar with live bio support
class AboutCardGrid extends StatelessWidget {
  final String bio1;
  final String bio2;

  const AboutCardGrid({
    super.key,
    required this.bio1,
    required this.bio2,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    final List<Widget> cards = [
      // Card 1: Core Bio & Background
      TiltCard(
        glowColor: AppColors.cyan,
        child: GlassContainer(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.cyan.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.person_pin_circle_outlined, color: AppColors.cyan, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Text('Background & Persona', style: AppTypography.cardTitle),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                bio1,
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: 12),
              Text(
                bio2,
                style: AppTypography.bodyMedium,
              ),
            ],
          ),
        ),
      ),

      // Card 2: Education & Academic Base
      TiltCard(
        glowColor: AppColors.blue,
        child: GlassContainer(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.blue.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.school_outlined, color: AppColors.blue, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Text('Formal Education', style: AppTypography.cardTitle),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                PortfolioData.educationDegree,
                style: AppTypography.cardTitle.copyWith(fontSize: 16, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 4),
              Text(
                PortfolioData.educationCollege,
                style: AppTypography.bodyMedium.copyWith(color: AppColors.cyan),
              ),
              const SizedBox(height: 4),
              Text(
                'Academic Tenure: ${PortfolioData.educationPeriod}',
                style: AppTypography.codeFont(color: AppColors.textMuted, fontSize: 12),
              ),
              const SizedBox(height: 16),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  TechBadge(label: 'Data Structures & Algorithms', color: AppColors.blue),
                  TechBadge(label: 'Operating Systems', color: AppColors.cyan),
                  TechBadge(label: 'Computer Networks', color: AppColors.emerald),
                  TechBadge(label: 'Database Management Systems', color: AppColors.purple),
                ],
              ),
            ],
          ),
        ),
      ),

      // Card 3: Engineering Philosophy & Learning Radar
      TiltCard(
        glowColor: AppColors.emerald,
        child: GlassContainer(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.emerald.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.radar_outlined, color: AppColors.emerald, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Text('Radar & Philosophy', style: AppTypography.cardTitle),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '• "Write software with mechanical sympathy: know the OS, the memory, and the network."',
                style: AppTypography.bodySmall.copyWith(color: AppColors.textPrimary, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 12),
              Text(
                'Current Learning Sprints:',
                style: AppTypography.codeFont(color: AppColors.emerald, fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  TechBadge(label: 'Dart FFI & C-Interop', color: AppColors.emerald),
                  TechBadge(label: 'Network Packet Forensics', color: AppColors.cyan),
                  TechBadge(label: 'Zero-Trust Architecture', color: AppColors.neonPink),
                  TechBadge(label: 'High-Performance Shaders', color: AppColors.electricViolet),
                ],
              ),
            ],
          ),
        ),
      ),
    ];

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: RevealAnimation(delay: const Duration(milliseconds: 100), child: cards[0])),
          const SizedBox(width: 20),
          Expanded(child: RevealAnimation(delay: const Duration(milliseconds: 250), child: cards[1])),
          const SizedBox(width: 20),
          Expanded(child: RevealAnimation(delay: const Duration(milliseconds: 400), child: cards[2])),
        ],
      );
    } else {
      return Column(
        children: [
          RevealAnimation(delay: const Duration(milliseconds: 100), child: cards[0]),
          const SizedBox(height: 16),
          RevealAnimation(delay: const Duration(milliseconds: 200), child: cards[1]),
          const SizedBox(height: 16),
          RevealAnimation(delay: const Duration(milliseconds: 300), child: cards[2]),
        ],
      );
    }
  }
}
