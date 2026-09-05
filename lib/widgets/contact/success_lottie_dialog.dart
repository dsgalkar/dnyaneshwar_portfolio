import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../common/glow_button.dart';

/// Animated Success Message Dialog when contact message is sent
class SuccessMessageDialog extends StatelessWidget {
  final String senderName;

  const SuccessMessageDialog({super.key, required this.senderName});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.surfaceElevated.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.emerald.withValues(alpha: 0.4), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.emerald.withValues(alpha: 0.25),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated glowing check icon
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [AppColors.emerald, AppColors.cyan],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.emerald.withValues(alpha: 0.5),
                          blurRadius: 20,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.check_rounded, color: Colors.black, size: 40),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Transmission Received!',
                    style: AppTypography.cardTitle.copyWith(fontSize: 22, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Thank you, $senderName. Your message has been prepared for dispatch. I will review your note and get back to you shortly.',
                    style: AppTypography.bodyMedium,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 28),

                  GlowButton(
                    text: 'Close Transmission',
                    variant: GlowButtonVariant.primary,
                    glowColor: AppColors.emerald,
                    onPressed: () => Navigator.pop(context),
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
