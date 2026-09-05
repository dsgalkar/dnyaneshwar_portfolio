import 'package:flutter/material.dart';

/// Centralized color palette for the futuristic, dark-cinematic portfolio
class AppColors {
  AppColors._();

  // Backgrounds
  static const Color background = Color(0xFF07090E);
  static const Color surface = Color(0xFF0D121D);
  static const Color surfaceElevated = Color(0xFF131B2A);
  static const Color surfaceGlass = Color(0x1AFFFFFF);
  static const Color surfaceGlassBorder = Color(0x26FFFFFF);

  // Primary Cyber Accents
  static const Color cyan = Color(0xFF00F2FE);
  static const Color blue = Color(0xFF4FACFE);
  static const Color purple = Color(0xFF7F00FF);
  static const Color neonPink = Color(0xFFFF007F);
  static const Color emerald = Color(0xFF00F5A0);
  static const Color electricViolet = Color(0xFF9D4EDD);

  // Status & Metrics
  static const Color success = Color(0xFF00E676);
  static const Color warning = Color(0xFFFFAB00);
  static const Color error = Color(0xFFFF5252);

  // Text Colors
  static const Color textPrimary = Color(0xFFF1F5F9);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textHighlight = Color(0xFF38BDF8);

  // Terminal Colors
  static const Color terminalBg = Color(0xFF05070B);
  static const Color terminalGreen = Color(0xFF4AF626);
  static const Color terminalCyan = Color(0xFF00F2FE);
  static const Color terminalYellow = Color(0xFFFFD166);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [cyan, blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleCyanGradient = LinearGradient(
    colors: [purple, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient emeraldCyanGradient = LinearGradient(
    colors: [emerald, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Color(0x1F2B3958), Color(0x0A101726)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF101726), Color(0xFF090D15)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
