import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class _OrbitNode {
  final String label;
  final String icon;
  final Color color;
  final double phi;   // latitude
  final double theta; // longitude

  _OrbitNode({
    required this.label,
    required this.icon,
    required this.color,
    required this.phi,
    required this.theta,
  });
}

/// 3D Spherical Orbit System projecting tech symbols with depth & mouse interaction
class InteractiveTechOrbit extends StatefulWidget {
  final double size;

  const InteractiveTechOrbit({
    super.key,
    this.size = 420.0,
  });

  @override
  State<InteractiveTechOrbit> createState() => _InteractiveTechOrbitState();
}

class _InteractiveTechOrbitState extends State<InteractiveTechOrbit> with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;
  double _manualAngleX = 0.0;
  double _manualAngleY = 0.0;

  final List<_OrbitNode> _nodes = [
    _OrbitNode(label: 'Flutter', icon: '⚡', color: AppColors.cyan, phi: 0.2, theta: 0.0),
    _OrbitNode(label: 'Dart', icon: '🎯', color: AppColors.blue, phi: 0.8, theta: 1.2),
    _OrbitNode(label: 'Firebase', icon: '🔥', color: AppColors.warning, phi: -0.6, theta: 2.1),
    _OrbitNode(label: 'Linux', icon: '🐧', color: AppColors.emerald, phi: 0.4, theta: 3.5),
    _OrbitNode(label: 'Security', icon: '🛡️', color: AppColors.neonPink, phi: -0.4, theta: 4.6),
    _OrbitNode(label: 'APIs', icon: '🌐', color: AppColors.electricViolet, phi: 0.7, theta: 5.4),
    _OrbitNode(label: 'Python', icon: '🐍', color: AppColors.cyan, phi: -0.8, theta: 0.7),
    _OrbitNode(label: 'Android', icon: '🤖', color: AppColors.success, phi: 0.0, theta: 2.8),
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 22),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent event, Size canvasSize) {
    final double centerX = canvasSize.width / 2;
    final double centerY = canvasSize.height / 2;
    setState(() {
      _manualAngleY = ((event.localPosition.dx - centerX) / centerX) * 0.4;
      _manualAngleX = ((event.localPosition.dy - centerY) / centerY) * -0.4;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double effectiveSize = math.min(widget.size, constraints.maxWidth);

        return MouseRegion(
          onHover: (e) => _onHover(e, Size(effectiveSize, effectiveSize)),
          onExit: (_) => setState(() {
            _manualAngleX = 0;
            _manualAngleY = 0;
          }),
          child: SizedBox(
            width: effectiveSize,
            height: effectiveSize,
            child: AnimatedBuilder(
              animation: _rotationController,
              builder: (context, child) {
                final double currentAngleY = (_rotationController.value * 2 * math.pi) + _manualAngleY;
                final double currentAngleX = _manualAngleX + math.sin(_rotationController.value * 2 * math.pi) * 0.15;
                final double radius = effectiveSize * 0.38;
                final Offset center = Offset(effectiveSize / 2, effectiveSize / 2);

                // Project 3D sphere points into 2D screen coordinates with z-depth sorting
                final List<Map<String, dynamic>> projectedNodes = [];

                for (final node in _nodes) {
                  // Spherical coordinates
                  final double x0 = radius * math.cos(node.phi) * math.cos(node.theta + currentAngleY);
                  final double y0 = radius * math.sin(node.phi);
                  final double z0 = radius * math.cos(node.phi) * math.sin(node.theta + currentAngleY);

                  // Rotate around X-axis
                  final double y1 = y0 * math.cos(currentAngleX) - z0 * math.sin(currentAngleX);
                  final double z1 = y0 * math.sin(currentAngleX) + z0 * math.cos(currentAngleX);
                  final double x1 = x0;

                  // 3D Perspective scale
                  final double perspective = 1.0 + (z1 / (radius * 2.5));
                  final double screenX = center.dx + x1 * perspective;
                  final double screenY = center.dy + y1 * perspective;

                  projectedNodes.add({
                    'node': node,
                    'screenX': screenX,
                    'screenY': screenY,
                    'z': z1,
                    'scale': perspective.clamp(0.65, 1.25),
                    'opacity': (0.35 + (z1 + radius) / (2 * radius) * 0.65).clamp(0.2, 1.0),
                  });
                }

                // Sort by Z so background nodes render behind foreground nodes
                projectedNodes.sort((a, b) => (a['z'] as double).compareTo(b['z'] as double));

                return Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Orbital rings custom painter
                    CustomPaint(
                      size: Size(effectiveSize, effectiveSize),
                      painter: _OrbitRingsPainter(
                        angleX: currentAngleX,
                        angleY: currentAngleY,
                        radius: radius,
                      ),
                    ),

                    // Central Glowing Core
                    Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const RadialGradient(
                          colors: [
                            Color(0x334F46E5),
                            Color(0x1A0EA5E9),
                            Color(0x00000000),
                          ],
                          stops: [0.0, 0.6, 1.0],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.blue.withValues(alpha: 0.15),
                            blurRadius: 30,
                            spreadRadius: 6,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.primaryGradient,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blue.withValues(alpha: 0.35),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'DG',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            fontSize: 18,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    ),

                    // Render 3D Projected Orbit Nodes
                    for (final p in projectedNodes) ...[
                      Positioned(
                        left: (p['screenX'] as double) - 40 * (p['scale'] as double),
                        top: (p['screenY'] as double) - 20 * (p['scale'] as double),
                        child: Opacity(
                          opacity: p['opacity'] as double,
                          child: Transform.scale(
                            scale: p['scale'] as double,
                            child: _OrbitItemBadge(node: p['node'] as _OrbitNode),
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _OrbitItemBadge extends StatelessWidget {
  final _OrbitNode node;

  const _OrbitItemBadge({required this.node});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: node.color.withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(node.icon, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(
            node.label,
            style: AppTypography.codeFont(
              color: AppColors.textPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrbitRingsPainter extends CustomPainter {
  final double angleX;
  final double angleY;
  final double radius;

  _OrbitRingsPainter({
    required this.angleX,
    required this.angleY,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final Paint ringPaint = Paint()
      ..color = AppColors.cyan.withValues(alpha: 0.12)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final Paint ringPaint2 = Paint()
      ..color = AppColors.purple.withValues(alpha: 0.10)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    canvas.save();
    canvas.translate(center.dx, center.dy);

    // Draw primary orbit ring
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: radius * 2.2, height: radius * 1.1),
      ringPaint,
    );

    // Draw secondary tilted orbit ring
    canvas.rotate(math.pi / 3 + angleX);
    canvas.drawOval(
      Rect.fromCenter(center: Offset.zero, width: radius * 2.0, height: radius * 0.9),
      ringPaint2,
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _OrbitRingsPainter oldDelegate) => true;
}
