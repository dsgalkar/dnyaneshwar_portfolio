import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/animations/custom_curves.dart';
import '../widgets/background/digital_grid_painter.dart';

/// Cinematic Splash Screen Sequence with 3D logo rotation, glowing laser line, and reveal transition
class SplashScreen extends StatefulWidget {
  final VoidCallback onSplashFinished;

  const SplashScreen({super.key, required this.onSplashFinished});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _gridDrawAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoRotationAnimation;
  late Animation<double> _laserLineWidthAnimation;
  late Animation<double> _laserLineOpacityAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _screenExitAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );

    // 1. Grid draw (0.0 to 0.4)
    _gridDrawAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
    );

    // 2. Logo appear, scale & slight 3D rotation (0.2 to 0.7)
    _logoScaleAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.65, curve: CustomCurves.smoothSpring),
      ),
    );

    _logoRotationAnimation = Tween<double>(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.65, curve: CustomCurves.easeOutCubic),
      ),
    );

    // 3. Subtitle text fade (0.45 to 0.75)
    _textFadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.45, 0.75, curve: Curves.easeIn),
    );

    // 4. Laser line draw across the screen (0.55 to 0.85)
    _laserLineWidthAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 0.85, curve: CustomCurves.easeOutCubic),
      ),
    );

    _laserLineOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.85, 0.98, curve: Curves.easeOut),
      ),
    );

    // 5. Overall exit zoom/fade (0.88 to 1.0)
    _screenExitAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.88, 1.0, curve: CustomCurves.cinematic),
      ),
    );

    _controller.forward().then((_) {
      widget.onSplashFinished();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _screenExitAnimation.value,
          child: Transform.scale(
            scale: 1.0 + (1.0 - _screenExitAnimation.value) * 0.1,
            child: Scaffold(
              backgroundColor: AppColors.background,
              body: Stack(
                alignment: Alignment.center,
                children: [
                  // Animated Cyber Grid
                  Positioned.fill(
                    child: CustomPaint(
                      painter: DigitalGridPainter(
                        progress: _gridDrawAnimation.value,
                        gridSize: 50,
                      ),
                    ),
                  ),

                  // Central Logo & Name Branding
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(_logoRotationAnimation.value * math.pi)
                            ..scaleByDouble(_logoScaleAnimation.value, _logoScaleAnimation.value, 1.0, 1.0),
                          alignment: FractionalOffset.center,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.primaryGradient,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.cyan.withValues(alpha: 0.5),
                                  blurRadius: 35,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'DG',
                              style: AppTypography.codeFont(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Opacity(
                          opacity: _textFadeAnimation.value,
                          child: Column(
                            children: [
                              Text(
                                'DNYANESHWAR GALKAR',
                                style: AppTypography.heroHeading(context, fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'COMPUTER ENGINEERING // DEVELOPER PORTFOLIO',
                                style: AppTypography.codeFont(
                                  color: AppColors.primaryIndigo,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Glowing Laser Line Sweep
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.35,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Opacity(
                        opacity: _laserLineOpacityAnimation.value,
                        child: Container(
                          height: 2,
                          width: MediaQuery.of(context).size.width * 0.7 * _laserLineWidthAnimation.value,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Colors.transparent,
                                AppColors.primaryIndigo,
                                AppColors.secondarySky,
                                Colors.transparent,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryIndigo.withValues(alpha: 0.4),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
