import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../state/auth_state.dart';
import '../../state/portfolio_state_manager.dart';
import '../common/glow_button.dart';
import 'admin_dashboard_modal.dart';

/// Floating HUD Bar at the bottom of the screen when Admin Mode is active
class AdminHudBar extends StatelessWidget {
  final AuthState authState;
  final PortfolioStateManager stateManager;

  const AdminHudBar({
    super.key,
    required this.authState,
    required this.stateManager,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 20,
      right: 20,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.cyan, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyan.withValues(alpha: 0.35),
                    blurRadius: 25,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pulsing Admin status dot
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: AppColors.cyan,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: AppColors.cyan, blurRadius: 8, spreadRadius: 2),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'ADMIN MODE ACTIVE',
                    style: AppTypography.codeFont(
                      color: AppColors.cyan,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 20),
                  GlowButton(
                    text: 'Control Panel',
                    icon: Icons.tune_rounded,
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    variant: GlowButtonVariant.primary,
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.black.withValues(alpha: 0.75),
                        builder: (ctx) => AdminDashboardModal(stateManager: stateManager),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  GlowButton(
                    text: 'Sign Out',
                    icon: Icons.logout_rounded,
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    variant: GlowButtonVariant.secondary,
                    onPressed: () {
                      authState.signOut();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: AppColors.surfaceElevated,
                          content: Text('Signed out. Returned to Guest Mode.', style: TextStyle(color: Colors.white)),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
