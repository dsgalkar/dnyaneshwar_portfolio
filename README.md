# Dnyaneshwar Galkar — Interactive Developer Portfolio (Flutter)

A futuristic, highly animated, and interactive developer portfolio application engineered with **Flutter & Dart**. Designed to run smoothly across **Desktop (Windows, macOS, Linux)**, **Web**, and **Mobile (Android, iOS)**.

---

## 🌟 Key Visual & Technical Highlights

- **Dark Cinematic Design System**: Dark theme (`#07090E`), curated Cyber Cyan & Neon Violet accents, Apple-grade typography via Google Fonts (`Outfit`, `Inter`, `Fira Code`), and subtle glassmorphic containers (`BackdropFilter`).
- **3D Tech Orbit Sphere (`InteractiveTechOrbit`)**: A 3D spherical node system in the hero section that calculates real-time $(x, y, z)$ projections and reacts smoothly to mouse hover.
- **Card 3D Perspective Tilt (`TiltCard`)**: Realistic matrix tilt (`Matrix4`) and dynamic glowing borders on hover for desktop and web.
- **Interactive Cyber Terminal (`InteractiveTerminal`)**: Fully functional command-line emulator supporting `whoami`, `about`, `skills`, `projects`, `vamint`, `achievements`, `matrix`, and `easteregg`.
- **Simulated GitHub Heatmap (`GithubActivityGraph`)**: 52-week contribution graph with interactive tooltip inspection.
- **VAMINT Leadership Showcase**: Dedicated section displaying club leadership, hackathon platforms, workshops, and community impact.
- **Deep Case Study Modals**: Rich dialogs breaking down problem statements, solutions, architecture, and learnings for each project.
- **Zero-Friction Customization**: 100% of the portfolio's content is centralized in `lib/data/portfolio_data.dart`.

---

## 📁 Project Architecture & Folder Structure

```
dnyaneshwar_portfolio/
├── pubspec.yaml
├── web/
│   ├── index.html
│   └── manifest.json
└── lib/
    ├── main.dart
    ├── app.dart
    ├── core/
    │   ├── theme/          # AppColors, AppTypography, AppTheme
    │   ├── constants/      # AppConstants, GlobalKeys, NavItems
    │   ├── animations/     # CustomCurves, AppAnimations, RevealAnimation
    │   └── utils/          # Responsive helper, UrlHelper
    ├── models/             # ProjectModel, SkillModel, ExperienceModel, AchievementModel, etc.
    ├── data/
    │   └── portfolio_data.dart # Single Source of Truth for all personal content
    ├── widgets/
    │   ├── common/         # GlassContainer, GlowButton, TechBadge, TiltCard, SectionTitle
    │   ├── background/     # AnimatedMeshGradient, InteractiveParticleField, DigitalGridPainter
    │   ├── cursor/         # CustomGlowCursor (Dual-ring glowing cursor)
    │   ├── navigation/     # DesktopGlassNavBar, MobileNavDrawer, ScrollProgressBar
    │   ├── hero/           # HeroIntroText, TypewriterText, InteractiveTechOrbit
    │   ├── about/          # AboutCardGrid, StatsRow
    │   ├── skills/         # SkillCategorySelector, SkillCard, SkillsSectionView
    │   ├── projects/       # ProjectCard, ProjectFilterChips, ProjectDetailDialog
    │   ├── timeline/       # GlowingTimelineItem, ExperienceTimeline
    │   ├── vamint/         # VamintBanner, VamintEventGrid
    │   ├── achievements/   # AchievementBadgeCard, CertificateModal
    │   ├── interactive/    # InteractiveTerminal, GithubActivityGraph, EasterEggOverlay
    │   ├── resume/         # ResumeSection
    │   └── contact/        # ContactForm, SocialLinksRow, SuccessMessageDialog
    └── screens/
        ├── splash_screen.dart # 3D rotating logo & laser sweep launch sequence
        └── home_screen.dart   # Main single-page scroll layout
```

---

## 🚀 Running the Project

### 1. Get Dependencies
```bash
flutter pub get
```

### 2. Run on Web
```bash
flutter run -d chrome
```

### 3. Run on Windows Desktop
```bash
flutter run -d windows
```

### 4. Run on Android Device / Emulator
```bash
flutter run -d android
```

---

## ⚙️ How to Customize Your Content

All portfolio content is isolated in **`lib/data/portfolio_data.dart`**. You do not need to touch any UI code to change your profile or add projects.

1. **Name & Titles**: Update `PortfolioData.name`, `PortfolioData.role`, and `PortfolioData.rotatingTitles`.
2. **Bio & Education**: Edit `PortfolioData.bioParagraph1`, `PortfolioData.bioParagraph2`, and `PortfolioData.educationDegree`.
3. **Projects**: Add or edit items in the `PortfolioData.projects` list. Include tags, GitHub URLs, and case study architecture notes.
4. **Skills**: Modify `PortfolioData.skills` with proficiency levels and linked project names.
5. **VAMINT & Activities**: Update `PortfolioData.vamintActivities` and `PortfolioData.experiences`.
6. **Achievements**: Add certificates, hackathon honors, and credential links in `PortfolioData.achievements`.
7. **Social Links**: Replace `email`, `githubUrl`, `linkedinUrl`, and `resumeUrl`.
