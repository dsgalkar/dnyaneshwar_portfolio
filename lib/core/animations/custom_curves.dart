import 'package:flutter/animation.dart';

/// Fluid easing curves matching premium UI benchmarks
class CustomCurves {
  CustomCurves._();

  // Smooth ease-out cubic
  static const Curve easeOutCubic = Cubic(0.215, 0.61, 0.355, 1.0);

  // Snappy yet smooth modal spring
  static const Curve smoothSpring = Cubic(0.175, 0.885, 0.32, 1.275);

  // Cinematic ease in-out
  static const Curve cinematic = Cubic(0.65, 0.05, 0.36, 1.0);

  // Magnetic button hover
  static const Curve magnetic = Cubic(0.25, 1.0, 0.5, 1.0);
}
