import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../data/portfolio_data.dart';
import '../common/glass_container.dart';

/// Distinctive futuristic banner introducing the VAMINT technical club & Dnyaneshwar's leadership
class VamintBanner extends StatelessWidget {
  const VamintBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(28),
      borderRadius: 20,
      gradient: const LinearGradient(
        colors: [
          Color(0x2E7F00FF),
          Color(0x1F00F2FE),
          Color(0x0A0D121D),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderColor: AppColors.purple.withValues(alpha: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: AppColors.purpleCyanGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.purple.withValues(alpha: 0.5),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Text('⚡', style: TextStyle(fontSize: 26)),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('VAMINT Technical Club', style: AppTypography.cardTitle.copyWith(fontSize: 24)),
                      Text(
                        'Core Lead & Tech Infrastructure Architect',
                        style: AppTypography.codeFont(color: AppColors.cyan, fontSize: 13, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.purple.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.purple.withValues(alpha: 0.5)),
                ),
                child: Text(
                  'LEADERSHIP',
                  style: AppTypography.codeFont(
                    color: AppColors.purple,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Text(
            PortfolioData.vamintDescription,
            style: AppTypography.bodyLarge,
          ),
        ],
      ),
    );
  }
}
