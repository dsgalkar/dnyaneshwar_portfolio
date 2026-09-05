import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_constants.dart';
import '../common/glow_button.dart';

/// Mobile Slide-out Menu and Bottom Navigation Trigger with Admin Status
class MobileNavDrawer extends StatelessWidget {
  final int activeIndex;
  final Function(int index) onTabSelected;
  final VoidCallback onResumePressed;
  final VoidCallback onAdminLoginPressed;
  final bool isAdmin;

  const MobileNavDrawer({
    super.key,
    required this.activeIndex,
    required this.onTabSelected,
    required this.onResumePressed,
    required this.onAdminLoginPressed,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(24)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated.withValues(alpha: 0.88),
              border: const Border(
                right: BorderSide(color: AppColors.surfaceGlassBorder),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'DG',
                            style: AppTypography.codeFont(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dnyaneshwar Galkar',
                                style: AppTypography.cardTitle.copyWith(fontSize: 16),
                              ),
                              Text(
                                isAdmin ? '⚡ Admin Mode Active' : 'Guest View',
                                style: AppTypography.codeFont(
                                  color: isAdmin ? AppColors.cyan : AppColors.textMuted,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(color: AppColors.surfaceGlassBorder, height: 1),

                  // Navigation Links
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      itemCount: AppConstants.navItems.length,
                      itemBuilder: (context, index) {
                        final String title = AppConstants.navItems[index];
                        final bool isActive = activeIndex == index;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: isActive ? AppColors.cyan.withValues(alpha: 0.12) : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isActive ? AppColors.cyan.withValues(alpha: 0.4) : Colors.transparent,
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(
                              _getNavIcon(index),
                              color: isActive ? AppColors.cyan : AppColors.textSecondary,
                              size: 20,
                            ),
                            title: Text(
                              title,
                              style: AppTypography.button.copyWith(
                                color: isActive ? AppColors.cyan : AppColors.textPrimary,
                                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              onTabSelected(index);
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  // Bottom Admin & Resume Actions
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        GlowButton(
                          text: isAdmin ? 'Admin Control Panel' : 'Sign In as Admin',
                          icon: isAdmin ? Icons.tune_rounded : Icons.lock_outline_rounded,
                          width: double.infinity,
                          variant: isAdmin ? GlowButtonVariant.primary : GlowButtonVariant.secondary,
                          onPressed: () {
                            Navigator.pop(context);
                            onAdminLoginPressed();
                          },
                        ),
                        const SizedBox(height: 10),
                        GlowButton(
                          text: 'Download Resume',
                          icon: Icons.download,
                          width: double.infinity,
                          variant: GlowButtonVariant.outline,
                          onPressed: () {
                            Navigator.pop(context);
                            onResumePressed();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getNavIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home_outlined;
      case 1:
        return Icons.person_outline;
      case 2:
        return Icons.code_rounded;
      case 3:
        return Icons.rocket_launch_outlined;
      case 4:
        return Icons.timeline_rounded;
      case 5:
        return Icons.mail_outline_rounded;
      default:
        return Icons.circle_outlined;
    }
  }
}
