import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/animations/custom_curves.dart';

enum GlowButtonVariant { primary, secondary, outline }

/// Interactive Futuristic Button with glowing ambient aura on hover
class GlowButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final GlowButtonVariant variant;
  final double? width;
  final double height;
  final Color? glowColor;
  final EdgeInsetsGeometry padding;

  const GlowButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.variant = GlowButtonVariant.primary,
    this.width,
    this.height = 48.0,
    this.glowColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  });

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final Color accent = widget.glowColor ?? AppColors.cyan;

    Color bgColor;
    Color textColor;
    Border? border;
    List<BoxShadow> shadows = [];

    switch (widget.variant) {
      case GlowButtonVariant.primary:
        bgColor = _isHovered ? accent : accent.withValues(alpha: 0.9);
        textColor = Colors.black;
        shadows = [
          BoxShadow(
            color: accent.withValues(alpha: _isHovered ? 0.6 : 0.25),
            blurRadius: _isHovered ? 24 : 14,
            spreadRadius: _isHovered ? 2 : 0,
            offset: const Offset(0, 4),
          ),
        ];
        break;
      case GlowButtonVariant.secondary:
        bgColor = _isHovered ? AppColors.surfaceElevated : AppColors.surfaceGlass;
        textColor = AppColors.textPrimary;
        border = Border.all(
          color: _isHovered ? accent : AppColors.surfaceGlassBorder,
          width: 1.2,
        );
        shadows = _isHovered
            ? [
                BoxShadow(
                  color: accent.withValues(alpha: 0.3),
                  blurRadius: 18,
                  spreadRadius: 1,
                )
              ]
            : [];
        break;
      case GlowButtonVariant.outline:
        bgColor = Colors.transparent;
        textColor = _isHovered ? accent : AppColors.textPrimary;
        border = Border.all(
          color: _isHovered ? accent : AppColors.textSecondary.withValues(alpha: 0.4),
          width: 1.2,
        );
        shadows = _isHovered
            ? [
                BoxShadow(
                  color: accent.withValues(alpha: 0.35),
                  blurRadius: 16,
                  spreadRadius: 1,
                )
              ]
            : [];
        break;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onPressed,
        child: AnimatedScale(
          scale: _isPressed
              ? 0.96
              : _isHovered
                  ? 1.03
                  : 1.0,
          duration: const Duration(milliseconds: 180),
          curve: CustomCurves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: CustomCurves.easeOutCubic,
            width: widget.width,
            height: widget.height,
            padding: widget.padding,
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: border,
              boxShadow: shadows,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    size: 18,
                    color: textColor,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  widget.text,
                  style: AppTypography.button.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
