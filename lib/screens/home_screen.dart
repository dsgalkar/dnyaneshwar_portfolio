import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../core/constants/app_constants.dart';
import '../core/utils/responsive.dart';
import '../models/project_model.dart';
import '../state/auth_state.dart';
import '../state/portfolio_state_manager.dart';
import '../widgets/admin/admin_login_dialog.dart';
import '../widgets/admin/admin_dashboard_modal.dart';
import '../widgets/admin/admin_hud_bar.dart';
import '../widgets/admin/forms/resume_form_dialog.dart';
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
import '../widgets/projects/project_filter_chips.dart';
import '../widgets/timeline/experience_timeline.dart';
import '../widgets/vamint/vamint_banner.dart';
import '../widgets/vamint/vamint_event_grid.dart';
import '../widgets/achievements/achievement_badge_card.dart';
import '../widgets/interactive/interactive_terminal.dart';
import '../widgets/interactive/github_activity_graph.dart';
import '../widgets/interactive/easter_egg_overlay.dart';
import '../widgets/resume/resume_section.dart';
import '../widgets/contact/contact_form.dart';
import '../widgets/contact/social_links_row.dart';

/// Main Landing View orchestrating all animated portfolio sections with Real-Time Admin CRUD
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
  String _selectedProjectCategory = 'All';
  bool _showEasterEgg = false;

  final List<GlobalKey> _sectionKeys = [
    AppConstants.heroKey,
    AppConstants.aboutKey,
    AppConstants.skillsKey,
    AppConstants.projectsKey,
    AppConstants.timelineKey,
    AppConstants.vamintKey,
    AppConstants.achievementsKey,
    AppConstants.terminalKey,
    AppConstants.resumeKey,
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
        barrierColor: Colors.black.withValues(alpha: 0.35),
        builder: (ctx) => AdminDashboardModal(stateManager: _stateManager),
      );
    } else {
      showDialog(
        context: context,
        barrierColor: Colors.black.withValues(alpha: 0.35),
        builder: (ctx) => AdminLoginDialog(
          authState: _authState,
          onLoginSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                content: Text('⚡ Authenticated as Admin! Control Panel unlocked.', style: TextStyle(color: AppColors.primaryIndigo, fontWeight: FontWeight.w600)),
              ),
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _authState.dispose();
    _stateManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final bool isTablet = Responsive.isTablet(context);

    final List<String> projectCategories = ['All', 'Mobile', 'Cybersecurity', 'AI / Data'];

    return AnimatedBuilder(
      animation: Listenable.merge([_authState, _stateManager]),
      builder: (context, child) {
        final List<ProjectModel> filteredProjects = _selectedProjectCategory == 'All'
            ? _stateManager.projects
            : _stateManager.projects.where((p) => p.category == _selectedProjectCategory).toList();

        return CustomGlowCursor(
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: AppColors.background,
            drawer: !isDesktop
                ? MobileNavDrawer(
                    activeIndex: _activeNavIndex,
                    isAdmin: _authState.isAdmin,
                    onTabSelected: _scrollToSection,
                    onResumePressed: () => _scrollToSection(8),
                    onAdminLoginPressed: _openAdminAuthOrDashboard,
                  )
                : null,
            body: Stack(
              children: [
                // Ambient Multi-Layer Background
                Positioned.fill(
                  child: AnimatedMeshGradient(
                    child: const InteractiveParticleField(particleCount: 40),
                  ),
                ),

                // Scrollable Portfolio Body
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: AppConstants.desktopMaxWidth),
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 60 : (isTablet ? 32 : 20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                          onDownloadResume: () => _scrollToSection(8),
                                          onContactMe: () => _scrollToSection(9),
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
                                        onDownloadResume: () => _scrollToSection(8),
                                        onContactMe: () => _scrollToSection(9),
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

                          // SECTION 3: PROJECTS
                          Container(
                            key: AppConstants.projectsKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SectionTitle(
                                  number: '03',
                                  title: 'Featured Engineering Builds',
                                  subtitle: 'Architectural case studies showcasing real-world problem solving, system architecture, and modern code craft.',
                                ),
                                ProjectFilterChips(
                                  categories: projectCategories,
                                  selectedCategory: _selectedProjectCategory,
                                  onCategorySelected: (cat) => setState(() => _selectedProjectCategory = cat),
                                ),
                                const SizedBox(height: 28),
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    final int crossAxis = isDesktop ? 3 : (isTablet ? 2 : 1);
                                    final double cardWidth = (constraints.maxWidth - (crossAxis - 1) * 20) / crossAxis;

                                    return Wrap(
                                      spacing: 20,
                                      runSpacing: 20,
                                      children: filteredProjects.map((proj) {
                                        return SizedBox(
                                          width: cardWidth,
                                          child: ProjectCard(project: proj),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 110),

                          // SECTION 4: EXPERIENCE & ACTIVITIES
                          Container(
                            key: AppConstants.timelineKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SectionTitle(
                                  number: '04',
                                  title: 'Experience & Milestones',
                                  subtitle: 'Chronological timeline of technical leadership, hackathons, open source contributions, and academic excellence.',
                                ),
                                ExperienceTimeline(experiences: _stateManager.experiences),
                              ],
                            ),
                          ),

                          const SizedBox(height: 110),

                          // SECTION 5: VAMINT COMMUNITY
                          Container(
                            key: AppConstants.vamintKey,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SectionTitle(
                                  number: '05',
                                  title: 'Community Leadership // VAMINT',
                                  subtitle: 'Empowering the next generation of engineers through hackathon platforms, hands-on bootcamps, and developer mentorship.',
                                ),
                                VamintBanner(),
                                SizedBox(height: 24),
                                VamintEventGrid(),
                              ],
                            ),
                          ),

                          const SizedBox(height: 110),

                          // SECTION 6: ACHIEVEMENTS & CERTIFICATES
                          Container(
                            key: AppConstants.achievementsKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SectionTitle(
                                  number: '06',
                                  title: 'Achievements & Credentials',
                                  subtitle: 'Validated milestones across national hackathons, technical certifications, and university recognitions.',
                                ),
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    final int crossAxis = isDesktop ? 2 : 1;
                                    final double cardWidth = (constraints.maxWidth - (crossAxis - 1) * 20) / crossAxis;

                                    return Wrap(
                                      spacing: 20,
                                      runSpacing: 20,
                                      children: _stateManager.achievements.map((ach) {
                                        return SizedBox(
                                          width: cardWidth,
                                          child: AchievementBadgeCard(achievement: ach),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 110),

                          // SECTION 7: INTERACTIVE TERMINAL & GITHUB GRAPH
                          Container(
                            key: AppConstants.terminalKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SectionTitle(
                                  number: '07',
                                  title: 'Interactive Console & Telemetry',
                                  subtitle: 'Run live bash commands to inspect my developer profile, test commands, or type "login" / "admin" to authenticate.',
                                ),
                                isDesktop
                                    ? Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: InteractiveTerminal(
                                              onTriggerMatrix: () => setState(() => _showEasterEgg = true),
                                              onTriggerEasterEgg: () => setState(() => _showEasterEgg = true),
                                              onTriggerLogin: _openAdminAuthOrDashboard,
                                            ),
                                          ),
                                          const SizedBox(width: 24),
                                          const Expanded(
                                            child: GithubActivityGraph(),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          InteractiveTerminal(
                                            onTriggerMatrix: () => setState(() => _showEasterEgg = true),
                                            onTriggerEasterEgg: () => setState(() => _showEasterEgg = true),
                                            onTriggerLogin: _openAdminAuthOrDashboard,
                                          ),
                                          const SizedBox(height: 20),
                                          const GithubActivityGraph(),
                                        ],
                                      ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 110),

                          // SECTION 8: MULTI-RESUME HUB
                          Container(
                            key: AppConstants.resumeKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SectionTitle(
                                  number: '08',
                                  title: 'Curriculum Vitae & Tailored Resumes',
                                  subtitle: 'View and download verified PDF resumes tailored for mobile engineering, cybersecurity, and full-stack software development.',
                                ),
                                ResumeSection(
                                  resumes: _stateManager.resumes,
                                  isAdmin: _authState.isAdmin,
                                  onAddResume: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => ResumeFormDialog(
                                        onSave: (res) => _stateManager.addResume(res),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 110),

                          // SECTION 9: CONTACT ME
                          Container(
                            key: AppConstants.contactKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SectionTitle(
                                  number: '09',
                                  title: "Let's Engineer Something Great",
                                  subtitle: 'Interested in discussing an internship, project collaboration, or technical challenge? Reach out directly.',
                                ),
                                isDesktop
                                    ? const Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(flex: 5, child: SocialLinksRow()),
                                          SizedBox(width: 28),
                                          Expanded(flex: 6, child: ContactForm()),
                                        ],
                                      )
                                    : const Column(
                                        children: [
                                          SocialLinksRow(),
                                          SizedBox(height: 24),
                                          ContactForm(),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '© ${DateTime.now().year} Dnyaneshwar Galkar. Engineered with Flutter & Dart.',
                                      style: AppTypography.codeFont(color: AppColors.textSecondary, fontSize: 12),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: _openAdminAuthOrDashboard,
                                          borderRadius: BorderRadius.circular(8),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Row(
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
                                              children: [
                                                const Text('👾', style: TextStyle(fontSize: 14)),
                                                const SizedBox(width: 6),
                                                Text(
                                                  'Easter Egg',
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

                // Top Desktop Glass Navbar or Mobile Floating Menu Bar
                if (isDesktop)
                  DesktopGlassNavBar(
                    activeIndex: _activeNavIndex,
                    isAdmin: _authState.isAdmin,
                    onTabSelected: _scrollToSection,
                    onResumePressed: () => _scrollToSection(8),
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
