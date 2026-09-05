import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_constants.dart';
import '../../core/animations/custom_curves.dart';
import '../common/glow_button.dart';

/// Floating Glassmorphic Top Navigation Bar with active indicators and Admin Auth trigger
class DesktopGlassNavBar extends StatelessWidget {
  final int activeIndex;
  final Function(int index) onTabSelected;
  final VoidCallback onResumePressed;
  final VoidCallback onAdminLoginPressed;
  final bool isAdmin;

  const DesktopGlassNavBar({
    super.key,
    required this.activeIndex,
    required this.onTabSelected,
    required this.onResumePressed,
    required this.onAdminLoginPressed,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1180),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated.withValues(alpha: 0.70),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isAdmin ? AppColors.cyan.withValues(alpha: 0.6) : AppColors.surfaceGlassBorder,
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 25,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand Logo
                    InkWell(
                      onTap: () => onTabSelected(0),
                      borderRadius: BorderRadius.circular(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.cyan.withValues(alpha: 0.4),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'DG',
                              style: AppTypography.codeFont(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Colors.white, Color(0xFF94A3B8)],
                            ).createShader(bounds),
                            child: Text(
                              'Dnyaneshwar.dev',
                              style: AppTypography.cardTitle.copyWith(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Nav Items
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(AppConstants.navItems.length, (index) {
                        final String title = AppConstants.navItems[index];
                        final bool isActive = activeIndex == index;

                        return _NavItem(
                          title: title,
                          isActive: isActive,
                          onTap: () => onTabSelected(index),
                        );
                      }),
                    ),

                    // Actions (Admin Button + Resume CTA)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GlowButton(
                          text: isAdmin ? 'Admin' : 'Sign In',
                          icon: isAdmin ? Icons.verified_user_rounded : Icons.lock_outline_rounded,
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          variant: isAdmin ? GlowButtonVariant.outline : GlowButtonVariant.secondary,
                          glowColor: isAdmin ? AppColors.emerald : AppColors.cyan,
                          onPressed: onAdminLoginPressed,
                        ),
                        const SizedBox(width: 8),
                        GlowButton(
                          text: 'Resume',
                          icon: Icons.description_outlined,
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          variant: GlowButtonVariant.primary,
                          onPressed: onResumePressed,
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

class _NavItem extends StatefulWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bool highlighted = widget.isActive || _isHovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: AppTypography.button.copyWith(
                  fontSize: 13,
                  color: highlighted ? AppColors.cyan : AppColors.textSecondary,
                  fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: CustomCurves.easeOutCubic,
                height: 2,
                width: widget.isActive ? 18 : _isHovered ? 10 : 0,
                decoration: BoxDecoration(
                  color: AppColors.cyan,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: widget.isActive
                      ? [
                          BoxShadow(
                            color: AppColors.cyan.withValues(alpha: 0.8),
                            blurRadius: 6,
                          ),
                        ]
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
