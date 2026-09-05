import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';

/// Custom Glowing Dual-Ring Cursor for Web & Desktop
class CustomGlowCursor extends StatefulWidget {
  final Widget child;

  const CustomGlowCursor({
    super.key,
    required this.child,
  });

  @override
  State<CustomGlowCursor> createState() => _CustomGlowCursorState();
}

class _CustomGlowCursorState extends State<CustomGlowCursor> {
  Offset _pointerPos = const Offset(-100, -100);
  bool _isVisible = false;
  bool _isHoveringInteractive = false;

  @override
  Widget build(BuildContext context) {
    // Only enable custom cursor on desktop / wide web screens where a mouse exists
    final bool enableCursor = (kIsWeb || !defaultTargetPlatform.name.contains('android')) &&
        !Responsive.isMobile(context);

    if (!enableCursor) {
      return widget.child;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onEnter: (_) => setState(() => _isVisible = true),
      onExit: (_) => setState(() => _isVisible = false),
      onHover: (event) {
        setState(() {
          _pointerPos = event.position;
          _isVisible = true;
        });
      },
      child: Stack(
        children: [
          widget.child,

          if (_isVisible) ...[
            // Outer trailing glowing ring
            AnimatedPositioned(
              duration: const Duration(milliseconds: 90),
              curve: Curves.easeOut,
              left: _pointerPos.dx - (_isHoveringInteractive ? 28 : 18),
              top: _pointerPos.dy - (_isHoveringInteractive ? 28 : 18),
              child: IgnorePointer(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: _isHoveringInteractive ? 56 : 36,
                  height: _isHoveringInteractive ? 56 : 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isHoveringInteractive ? AppColors.cyan : AppColors.cyan.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.cyan.withValues(alpha: _isHoveringInteractive ? 0.35 : 0.15),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Inner precise glowing dot
            Positioned(
              left: _pointerPos.dx - 3,
              top: _pointerPos.dy - 3,
              child: IgnorePointer(
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.cyan,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.cyan,
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
