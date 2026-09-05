import 'package:flutter/material.dart';

/// App Constants, Layout Metrics, and Section Keys
class AppConstants {
  AppConstants._();

  // Breakpoints
  static const double mobileMaxWidth = 768.0;
  static const double tabletMaxWidth = 1100.0;
  static const double desktopMaxWidth = 1400.0;

  // Max Content Width
  static const double maxContentWidth = 1200.0;

  // Section Keys for Smooth Scroll Synchronization
  static final GlobalKey heroKey = GlobalKey();
  static final GlobalKey aboutKey = GlobalKey();
  static final GlobalKey skillsKey = GlobalKey();
  static final GlobalKey projectsKey = GlobalKey();
  static final GlobalKey timelineKey = GlobalKey();
  static final GlobalKey vamintKey = GlobalKey();
  static final GlobalKey achievementsKey = GlobalKey();
  static final GlobalKey terminalKey = GlobalKey();
  static final GlobalKey resumeKey = GlobalKey();
  static final GlobalKey contactKey = GlobalKey();

  // Navigation Items
  static const List<String> navItems = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Experience',
    'VAMINT',
    'Achievements',
    'Terminal',
    'Resume',
    'Contact',
  ];
}
