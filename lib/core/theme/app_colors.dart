import 'package:flutter/material.dart';

/// Centralized color palette for the modern, aesthetic pleasant-light portfolio
class AppColors {
  AppColors._();

  // Backgrounds & Surfaces (Aesthetic Porcelain & Ivory)
  static const Color background = Color(0xFFF8FAFC);
  static const Color backgroundAlt = Color(0xFFF1F5F9);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  static const Color surfaceGlass = Color(0xCCFFFFFF);
  static const Color surfaceGlassBorder = Color(0xFFE2E8F0);

  // Slate Scale
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  // Modern Aesthetic Accents (Soft Indigo, Sky Blue, Rose, Mint, Violet)
  static const Color primaryIndigo = Color(0xFF4F46E5); // Royal Indigo
  static const Color secondarySky = Color(0xFF0EA5E9); // Modern Sky
  static const Color rosePink = Color(0xFFF43F5E); // Soft Rose Coral
  static const Color mintGreen = Color(0xFF10B981); // Emerald Mint
  static const Color violet = Color(0xFF7C3AED); // Violet

  // Backward-compatible aliases
  static const Color cyan = secondarySky;
  static const Color blue = primaryIndigo;
  static const Color purple = violet;
  static const Color neonPink = rosePink;
  static const Color emerald = mintGreen;
  static const Color electricViolet = Color(0xFF8B5CF6);
  static const Color amber = Color(0xFFF59E0B);

  // Status & Metrics
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // High-Contrast Refined Typography
  static const Color textPrimary = Color(0xFF0F172A); // Deep Charcoal Slate
  static const Color textSecondary = Color(0xFF475569); // Medium Slate
  static const Color textMuted = Color(0xFF94A3B8); // Light Slate
  static const Color textHighlight = Color(0xFF4F46E5); // Vibrant Indigo

  // Terminal / Code Block Colors (Pleasant Light Aesthetic)
  static const Color terminalBg = Color(0xFFF8FAFC);
  static const Color terminalGreen = Color(0xFF059669);
  static const Color terminalCyan = Color(0xFF0284C7);
  static const Color terminalYellow = Color(0xFFD97706);

  // Aesthetic Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [blue, cyan],
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

  static const LinearGradient roseIndigoGradient = LinearGradient(
    colors: [neonPink, blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Color(0xF5FFFFFF), Color(0xEBEEF2F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

