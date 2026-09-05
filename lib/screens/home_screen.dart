import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/constants/app_constants.dart';
import '../core/utils/responsive.dart';
import '../state/auth_state.dart';
import '../state/portfolio_state_manager.dart';
import '../widgets/admin/admin_login_dialog.dart';
import '../widgets/admin/admin_dashboard_modal.dart';
import '../widgets/admin/admin_hud_bar.dart';
import '../widgets/background/animated_mesh_gradient.dart';
import '../widgets/background/interactive_particle_field.dart';
import '../widgets/cursor/custom_glow_cursor.dart';
import '../widgets/navigation/desktop_glass_navbar.dart';
import '../widgets/navigation/mobile_nav_drawer.dart';
import '../widgets/navigation/scroll_progress_bar.dart';
import '../widgets/common/section_title.dart';
import '../widgets/hero/hero_intro_text.dart';
import '../widgets/hero/interactive_tech_orbit.dart';
import '../widgets/about/stats_row.dart';
import '../widgets/about/about_card_grid.dart';
import '../widgets/skills/interactive_skill_orbit.dart';
import '../widgets/projects/project_card.dart';
import '../widgets/timeline/experience_timeline.dart';
import '../widgets/interactive/easter_egg_overlay.dart';
import '../widgets/contact/contact_form.dart';
import '../widgets/contact/social_links_row.dart';
import '../core/utils/url_helper.dart';
import '../data/portfolio_data.dart';

/// Main Landing View with clean pleasant aesthetic and streamlined single demo builds
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AuthState _authState = AuthState();
  final PortfolioStateManager _stateManager = PortfolioStateManager();

  int _activeNavIndex = 0;
  double _scrollProgress = 0.0;
  bool _showEasterEgg = false;

  final List<GlobalKey> _sectionKeys = [
    AppConstants.heroKey,
    AppConstants.aboutKey,
    AppConstants.skillsKey,
    AppConstants.projectsKey,
    AppConstants.timelineKey,
    AppConstants.contactKey,
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final double maxScroll = _scrollController.position.maxScrollExtent;
    final double currentScroll = _scrollController.offset;

    setState(() {
      _scrollProgress = (maxScroll > 0) ? (currentScroll / maxScroll) : 0.0;
    });

    // Determine current active section
    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final key = _sectionKeys[i];
      final BuildContext? ctx = key.currentContext;
      if (ctx != null) {
        final RenderBox? box = ctx.findRenderObject() as RenderBox?;
        if (box != null) {
          final Offset offset = box.localToGlobal(Offset.zero);
          if (offset.dy <= 200) {
            if (_activeNavIndex != i) {
              setState(() => _activeNavIndex = i);
            }
            break;
          }
        }
      }
    }
  }

  void _scrollToSection(int index) {
    if (index >= _sectionKeys.length) return;
    final GlobalKey targetKey = _sectionKeys[index];
    final BuildContext? targetContext = targetKey.currentContext;

    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _openAdminAuthOrDashboard() {
    if (_authState.isAdmin) {
      showDialog(
        context: context,
        barrierColor: const Color(0xFF0F172A).withValues(alpha: 0.35),
        builder: (ctx) => AdminDashboardModal(stateManager: _stateManager),
      );
    } else {
      showDialog(
        context: context,
        barrierColor: const Color(0xFF0F172A).withValues(alpha: 0.35),
        builder: (ctx) => AdminLoginDialog(
          authState: _authState,
          onLoginSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: AppColors.mintGreen,
                content: Text('Authenticated successfully as Admin!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _authState.dispose();
    _stateManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return ListenableBuilder(
      listenable: Listenable.merge([_authState, _stateManager]),
      builder: (context, _) {
        return CustomGlowCursor(
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: AppColors.background,
            drawer: MobileNavDrawer(
              activeIndex: _activeNavIndex,
              isAdmin: _authState.isAdmin,
              onTabSelected: _scrollToSection,
              onResumePressed: () => UrlHelper.launchURL(PortfolioData.resumeUrl),
              onAdminLoginPressed: _openAdminAuthOrDashboard,
            ),
            body: Stack(
              children: [
                // Animated Pleasant Mesh Gradient & Particle Field
                Positioned.fill(
                  child: AnimatedMeshGradient(
                    child: const InteractiveParticleField(particleCount: 30),
                  ),
                ),

                // Main Scrollable Body
                Positioned.fill(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
                        padding: EdgeInsets.symmetric(
                          horizontal: isDesktop ? 40 : 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: isDesktop ? 120 : 90),

                            // SECTION 0: HERO SECTION
                            Container(
                              key: AppConstants.heroKey,
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: isDesktop
                                  ? Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: HeroIntroText(
                                            onViewWork: () => _scrollToSection(3),
                                            onDownloadResume: () => UrlHelper.launchURL(PortfolioData.resumeUrl),
                                            onContactMe: () => _scrollToSection(5),
                                          ),
                                        ),
                                        const SizedBox(width: 40),
                                        const Expanded(
                                          flex: 5,
                                          child: Center(
                                            child: InteractiveTechOrbit(size: 420),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        const Center(
                                          child: InteractiveTechOrbit(size: 320),
                                        ),
                                        const SizedBox(height: 36),
                                        HeroIntroText(
                                          onViewWork: () => _scrollToSection(3),
                                          onDownloadResume: () => UrlHelper.launchURL(PortfolioData.resumeUrl),
                                          onContactMe: () => _scrollToSection(5),
                                        ),
                                      ],
                                    ),
                            ),

                            const SizedBox(height: 60),

                            // STATS COUNTER ROW
                            const StatsRow(),

                            const SizedBox(height: 100),

                            // SECTION 1: ABOUT ME
                            Container(
                              key: AppConstants.aboutKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SectionTitle(
                                    number: '01',
                                    title: 'Engineering Mindset & Education',
                                    subtitle: 'Building a robust foundation across core computer science principles and active developer leadership.',
                                  ),
                                  AboutCardGrid(
                                    bio1: _stateManager.bio1,
                                    bio2: _stateManager.bio2,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 110),

                            // SECTION 2: SKILLS
                            Container(
                              key: AppConstants.skillsKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SectionTitle(
                                    number: '02',
                                    title: 'Technical Arsenal & Competencies',
                                    subtitle: 'Interactive technology system grouped across core development, security protocols, and data engineering.',
                                  ),
                                  SkillsSectionView(skills: _stateManager.skills),
                                ],
                              ),
                            ),

                            const SizedBox(height: 110),

                            // SECTION 3: FEATURED PROJECT (1 Flagship Build for Demo)
                            Container(
                              key: AppConstants.projectsKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SectionTitle(
                                    number: '03',
                                    title: 'Featured Engineering Build',
                                    subtitle: 'Architectural case study showcasing real-world problem solving, system architecture, and modern code craft.',
                                  ),
                                  ProjectCard(project: _stateManager.projects.first),
                                ],
                              ),
                            ),

                            const SizedBox(height: 110),

                            // SECTION 4: FEATURED EXPERIENCE (1 Flagship Milestone for Demo)
                            Container(
                              key: AppConstants.timelineKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SectionTitle(
                                    number: '04',
                                    title: 'Leadership & Experience Milestone',
                                    subtitle: 'Highlighting community leadership, technical mentorship, and high-scale event platform engineering.',
                                  ),
                                  ExperienceTimeline(experiences: _stateManager.experiences),
                                ],
                              ),
                            ),

                            const SizedBox(height: 110),

                            // SECTION 5: CONTACT & CONNECT
                            Container(
                              key: AppConstants.contactKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SectionTitle(
                                    number: '05',
                                    title: "Let's Connect & Build Together",
                                    subtitle: 'Interested in discussing an internship, project collaboration, or technical challenge? Reach out directly.',
                                  ),
                                  isDesktop
                                      ? Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Expanded(flex: 5, child: SocialLinksRow()),
                                            const SizedBox(width: 28),
                                            Expanded(flex: 6, child: ContactForm(stateManager: _stateManager)),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            const SocialLinksRow(),
                                            const SizedBox(height: 24),
                                            ContactForm(stateManager: _stateManager),
                                          ],
                                        ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 100),

                            // FOOTER
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 36.0),
                              child: Column(
                                children: [
                                  Divider(color: AppColors.slate200),
                                  const SizedBox(height: 20),
                                  Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    spacing: 16,
                                    runSpacing: 14,
                                    children: [
                                      Text(
                                        '© ${DateTime.now().year} Dnyaneshwar Galkar. Engineered with Flutter & Dart.',
                                        style: AppTypography.codeFont(color: AppColors.textSecondary, fontSize: 12),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: _openAdminAuthOrDashboard,
                                            borderRadius: BorderRadius.circular(8),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(_authState.isAdmin ? Icons.verified_user_rounded : Icons.admin_panel_settings_outlined, size: 14, color: AppColors.primaryIndigo),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    _authState.isAdmin ? 'Admin Console' : 'Admin Login',
                                                    style: AppTypography.codeFont(color: AppColors.primaryIndigo, fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 14),
                                          InkWell(
                                            onTap: () => setState(() => _showEasterEgg = true),
                                            borderRadius: BorderRadius.circular(8),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text('✨', style: TextStyle(fontSize: 14)),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    'Quick Demo',
                                                    style: AppTypography.codeFont(color: AppColors.primaryIndigo, fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Top Desktop Glass Navbar
                if (isDesktop)
                  DesktopGlassNavBar(
                    activeIndex: _activeNavIndex,
                    isAdmin: _authState.isAdmin,
                    onTabSelected: _scrollToSection,
                    onResumePressed: () => UrlHelper.launchURL(PortfolioData.resumeUrl),
                    onAdminLoginPressed: _openAdminAuthOrDashboard,
                  )
                else
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryIndigo.withValues(alpha: 0.25),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text('DG', style: AppTypography.codeFont(color: Colors.white, fontWeight: FontWeight.w900)),
                        ),
                        Row(
                          children: [
                            if (_authState.isAdmin)
                              IconButton(
                                icon: const Icon(Icons.tune_rounded, color: AppColors.mintGreen, size: 24),
                                style: IconButton.styleFrom(backgroundColor: Colors.white.withValues(alpha: 0.9)),
                                onPressed: _openAdminAuthOrDashboard,
                              ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.menu_rounded, color: AppColors.primaryIndigo, size: 28),
                              style: IconButton.styleFrom(backgroundColor: Colors.white.withValues(alpha: 0.9)),
                              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                // Glowing Scroll Progress Bar
                ScrollProgressBar(progress: _scrollProgress),

                // Floating Admin HUD Bar when in Admin Mode
                if (_authState.isAdmin)
                  AdminHudBar(
                    authState: _authState,
                    stateManager: _stateManager,
                  ),

                // Easter Egg Screen Overlay
                if (_showEasterEgg)
                  Positioned.fill(
                    child: EasterEggOverlay(
                      onClose: () => setState(() => _showEasterEgg = false),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
