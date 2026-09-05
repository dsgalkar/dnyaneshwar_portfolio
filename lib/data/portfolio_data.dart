import '../models/project_model.dart';
import '../models/skill_model.dart';
import '../models/experience_model.dart';
import '../models/achievement_model.dart';
import '../models/activity_model.dart';
import '../models/stat_model.dart';

/// Centralized Data Hub for Dnyaneshwar Galkar's Portfolio.
/// Update content here and it instantly updates across the entire application.
class PortfolioData {
  PortfolioData._();

  // Personal Information
  static const String name = 'Dnyaneshwar Galkar';
  static const String initials = 'DG';
  static const String role = 'Computer Engineering Student & Developer';
  static const String tagline = 'Building scalable mobile ecosystems, exploring cybersecurity horizons, and engineering fluid digital experiences.';
  
  static const List<String> rotatingTitles = [
    'Flutter & Android Developer',
    'Cybersecurity Enthusiast',
    'Computer Engineering Student',
    'Problem Solver & Builder',
    'Tech Explorer',
  ];

  static const String bioParagraph1 = 
      'I am a Computer Engineering student driven by the art of architecting resilient software systems. '
      'My primary engineering focus centers on high-performance cross-platform Flutter applications, secure backend integrations, '
      'and practical cybersecurity paradigms.';

  static const String bioParagraph2 = 
      'Beyond code syntax, I build and lead tech communities. As an active core contributor at VAMINT, '
      'I orchestrate technical hackathons, conduct hands-on workshops, and mentor aspiring developers in bridging the gap '
      'between academic fundamentals and real-world system architecture.';

  static const String educationDegree = 'Bachelor of Engineering in Computer Engineering';
  static const String educationCollege = 'Savitribai Phule Pune University';
  static const String educationPeriod = '2023 — 2027';

  // Contact & Social Links
  static const String email = 'dnyaneshwargalkar@gmail.com';
  static const String githubUrl = 'https://github.com/dnyaneshwargalkar';
  static const String linkedinUrl = 'https://linkedin.com/in/dnyaneshwargalkar';
  static const String twitterUrl = 'https://twitter.com/dnyaneshwar_g';
  static const String resumeUrl = 'https://raw.githubusercontent.com/dnyaneshwargalkar/resume/main/resume.pdf';

  // Key Animated Metrics
  static const List<StatModel> stats = [
    StatModel(count: 15, suffix: '+', label: 'Projects Built', icon: '💻'),
    StatModel(count: 1200, suffix: '+', label: 'Git Commits', icon: '🔥'),
    StatModel(count: 8, suffix: '+', label: 'Hackathons & Events', icon: '🏆'),
    StatModel(count: 500, suffix: '+', label: 'Community Peers Mentored', icon: '👥'),
  ];

  // Skills Data Catalog
  static const List<SkillModel> skills = [
    // Programming
    SkillModel(
      name: 'Dart',
      category: SkillCategory.programming,
      proficiency: 0.95,
      description: 'Expert in Dart language internals, asynchronous streams, isolates, and robust null-safe design patterns.',
      relatedTech: ['Flutter', 'Async/Await', 'Isolates', 'OOP'],
      usedInProjects: ['CyberShield Guard', 'OmniFlow Task Ecosystem', 'VAMINT Connect'],
      iconKey: 'dart',
    ),
    SkillModel(
      name: 'Python',
      category: SkillCategory.programming,
      proficiency: 0.88,
      description: 'Applied for data processing, cybersecurity scripting, network packet parsing, and automated workflows.',
      relatedTech: ['Scapy', 'NumPy', 'Pandas', 'Flask'],
      usedInProjects: ['NetSentinel IDS', 'DataLens Analytics'],
      iconKey: 'python',
    ),
    SkillModel(
      name: 'Java',
      category: SkillCategory.programming,
      proficiency: 0.82,
      description: 'Core OOP mastery, multi-threading, Android SDK fundamentals, and algorithmic data structures.',
      relatedTech: ['Android SDK', 'Multithreading', 'JVM'],
      usedInProjects: ['Android Native Modules'],
      iconKey: 'java',
    ),
    SkillModel(
      name: 'C / C++',
      category: SkillCategory.programming,
      proficiency: 0.85,
      description: 'Low-level memory management, pointers, system-level algorithms, and data structure implementations.',
      relatedTech: ['Pointers', 'Memory Allocation', 'STL', 'Compilers'],
      usedInProjects: ['Custom Memory Allocator', 'OS Kernel Simulators'],
      iconKey: 'cpp',
    ),

    // App Development
    SkillModel(
      name: 'Flutter',
      category: SkillCategory.appDev,
      proficiency: 0.94,
      description: 'Specialized in custom render objects, 60fps animations, Riverpod/Bloc state management, and multi-platform compilation.',
      relatedTech: ['CustomPainter', 'Riverpod', 'Clean Architecture', 'Animations'],
      usedInProjects: ['CyberShield Guard', 'OmniFlow Ecosystem', 'VAMINT App'],
      iconKey: 'flutter',
    ),
    SkillModel(
      name: 'Android Development',
      category: SkillCategory.appDev,
      proficiency: 0.84,
      description: 'Understanding of Android lifecycles, background services, intent filters, and JNI/FFI bridging.',
      relatedTech: ['Services', 'Broadcast Receivers', 'NDK', 'Gradle'],
      usedInProjects: ['CyberShield Guard', 'Android Security Audits'],
      iconKey: 'android',
    ),
    SkillModel(
      name: 'Firebase Suite',
      category: SkillCategory.appDev,
      proficiency: 0.90,
      description: 'Cloud Firestore schema modeling, secure rule evaluation, Firebase Auth, Cloud Functions, and push notifications.',
      relatedTech: ['Firestore', 'Auth', 'Cloud Functions', 'FCM'],
      usedInProjects: ['OmniFlow Ecosystem', 'VAMINT Connect'],
      iconKey: 'firebase',
    ),

    // Web & APIs
    SkillModel(
      name: 'REST APIs & WebSockets',
      category: SkillCategory.web,
      proficiency: 0.90,
      description: 'Designing and consuming high-throughput HTTP/REST endpoints and real-time bidirectional WebSocket pipes.',
      relatedTech: ['JSON', 'WebSockets', 'OAuth2.0', 'Postman'],
      usedInProjects: ['NetSentinel IDS', 'OmniFlow Ecosystem'],
      iconKey: 'api',
    ),
    SkillModel(
      name: 'HTML5 & Modern CSS',
      category: SkillCategory.web,
      proficiency: 0.88,
      description: 'Semantic markup, modern layout algorithms, responsive typography, and glassmorphism styling.',
      relatedTech: ['Flexbox', 'CSS Grid', 'Glassmorphism', 'Responsive Design'],
      usedInProjects: ['Developer Showcase', 'VAMINT Portal'],
      iconKey: 'html',
    ),
    SkillModel(
      name: 'JavaScript / Node.js',
      category: SkillCategory.web,
      proficiency: 0.82,
      description: 'Asynchronous event loops, backend microservices, and serverless cloud functions.',
      relatedTech: ['Node.js', 'Express', 'JWT', 'Async I/O'],
      usedInProjects: ['Auth Middleware Gateway'],
      iconKey: 'javascript',
    ),

    // Cybersecurity & OS
    SkillModel(
      name: 'Linux & Shell Scripting',
      category: SkillCategory.cybersecurity,
      proficiency: 0.92,
      description: 'System administration, Bash automation, file permissions, kernel signals, and environment hardening.',
      relatedTech: ['Bash', 'Kali Linux', 'Ubuntu Server', 'Cron'],
      usedInProjects: ['Automated Server Auditor', 'NetSentinel IDS'],
      iconKey: 'linux',
    ),
    SkillModel(
      name: 'Network Security & Protocols',
      category: SkillCategory.cybersecurity,
      proficiency: 0.86,
      description: 'Deep understanding of TCP/IP, OSI model, packet sniffing (Wireshark), firewall rule sets, and SSL/TLS handshakes.',
      relatedTech: ['Wireshark', 'Nmap', 'TCP/IP', 'SSL/TLS'],
      usedInProjects: ['NetSentinel IDS', 'Packet Inspector'],
      iconKey: 'network',
    ),
    SkillModel(
      name: 'Ethical Hacking & Vulnerability Analysis',
      category: SkillCategory.cybersecurity,
      proficiency: 0.80,
      description: 'Vulnerability assessment, OWASP Top 10 mitigations, reverse engineering basics, and secure code audits.',
      relatedTech: ['OWASP Top 10', 'Burp Suite', 'Penetration Testing'],
      usedInProjects: ['CyberShield Guard'],
      iconKey: 'security',
    ),

    // Data & Analytics
    SkillModel(
      name: 'SQL & Database Architecture',
      category: SkillCategory.data,
      proficiency: 0.85,
      description: 'Relational schema normalization, complex joins, index optimization, and transaction safety (ACID).',
      relatedTech: ['PostgreSQL', 'SQLite', 'Indexes', 'Triggers'],
      usedInProjects: ['OmniFlow Ecosystem', 'Academic LMS DB'],
      iconKey: 'sql',
    ),
    SkillModel(
      name: 'Data Analysis & Visualization',
      category: SkillCategory.data,
      proficiency: 0.82,
      description: 'Extracting actionable metrics, telemetry trends, statistical modeling, and charting.',
      relatedTech: ['Pandas', 'Matplotlib', 'Data Cleaning'],
      usedInProjects: ['DataLens Analytics'],
      iconKey: 'chart',
    ),

    // Tools
    SkillModel(
      name: 'Git & GitHub CI/CD',
      category: SkillCategory.tools,
      proficiency: 0.92,
      description: 'Advanced branching strategies, rebasing, pull-request code reviews, and automated GitHub Actions workflows.',
      relatedTech: ['Actions', 'Rebase', 'Code Review', 'Git Flow'],
      usedInProjects: ['All Repositories'],
      iconKey: 'git',
    ),
    SkillModel(
      name: 'VS Code & Android Studio',
      category: SkillCategory.tools,
      proficiency: 0.95,
      description: 'Power-user workflows with memory profiling, CPU trace analysis, and Flutter DevTools debugging.',
      relatedTech: ['DevTools', 'Profiler', 'Emulator Config'],
      usedInProjects: ['All Projects'],
      iconKey: 'tools',
    ),
  ];

  // Featured Projects Case Studies (1 Flagship Demo Project)
  static const List<ProjectModel> projects = [
    ProjectModel(
      id: 'cybershield-guard',
      title: 'CyberShield Guard',
      tagline: 'On-device network monitor & vulnerability scanner with live packet telemetry.',
      description: 'A mobile-first cybersecurity suite built with Flutter and native Android bridging. Analyzes WiFi network vulnerabilities, detects ARP spoofing attacks, and scores local device security posture in real-time.',
      problem: 'Mobile users on public Wi-Fi networks are constantly vulnerable to man-in-the-middle attacks, DNS hijacking, and unauthorized device probing without having accessible diagnostic tools.',
      solution: 'Engineered an intuitive mobile application that performs background network telemetry, flags ARP poisoning attempts instantly, and provides actionable remediation guidance.',
      features: [
        'Real-time ARP spoofing & MITM attack detection engine',
        'Local port scanner and open port risk assessment',
        'Cryptographic hash verification tool for downloaded files',
        'Offline vulnerability signature database',
        'Interactive real-time latency & packet throughput graphs'
      ],
      technologies: ['Flutter', 'Dart', 'Android Native (JNI)', 'Scapy', 'AES-256', 'CustomPainter'],
      architecture: 'Clean Architecture with separate Network Scanning isolate, Event Stream Controller, and reactive UI presentation layer.',
      challenges: 'Running low-level socket inspections within Android permission sandboxes without depleting battery reserves.',
      learnings: 'Mastered Dart Isolates for background computation and native Android NetworkCapabilities APIs.',
      githubUrl: 'https://github.com/dnyaneshwargalkar/cybershield-guard',
      liveDemoUrl: 'https://cybershield.web.app',
      category: 'Cybersecurity',
      isFeatured: true,
      iconSymbol: '🛡️',
    ),
  ];

  // Experience & Milestones Timeline (1 Flagship Demo Experience)
  static const List<ExperienceModel> experiences = [
    ExperienceModel(
      title: 'Technical Core Team & Developer Lead',
      organization: 'VAMINT Technical Community',
      period: '2024 — Present',
      roleType: 'Leadership',
      description: 'Leading technical initiatives, guiding student teams in project architecture, and architecting community apps for flagship college symposiums.',
      highlights: [
        'Spearheaded the official VAMINT event application, serving 600+ active participants during technical symposiums.',
        'Conducted 5+ hands-on technical workshops on Flutter App Development and Linux system internals.',
        'Mentored 40+ junior developers across their first open-source contributions and hackathon submissions.'
      ],
      tags: ['Flutter', 'Community Leadership', 'Mentorship', 'Workshops', 'Event Tech'],
      icon: '🚀',
    ),
  ];

  // VAMINT Dedication Section Content
  static const String vamintDescription = 
      'VAMINT is a forward-thinking technical community and innovation club dedicated to empowering engineering students '
      'through hands-on engineering, hackathons, and collaborative problem-solving. '
      'As a core lead, I spearhead software development, build event infrastructure, and foster a culture of active builders.';

  static const List<ActivityModel> vamintActivities = [
    ActivityModel(
      title: 'VAMINT Hackathon 2024 Tech Platform',
      eventType: 'Product Development',
      date: 'OCT 2024',
      description: 'Architected and deployed the real-time registration, leaderboard, and project evaluation dashboard for 500+ participants.',
      impact: 'Zero downtime across 36 hours; processed 120+ team submissions seamlessly.',
      tags: ['Flutter Web', 'Firebase', 'Real-time sync'],
      icon: '💻',
    ),
    ActivityModel(
      title: 'Flutter & Modern App Architecture Bootcamps',
      eventType: 'Technical Workshop',
      date: 'AUG 2024',
      description: 'Conducted a 3-day deep-dive bootcamp teaching 150+ students how to build production-grade Flutter apps with state management and clean architecture.',
      impact: 'Resulted in 25+ new student-built Flutter apps published on GitHub.',
      tags: ['Workshop', 'Flutter', 'Mentorship'],
      icon: '🎓',
    ),
    ActivityModel(
      title: 'Cyber Defense & Linux Essentials Sessions',
      eventType: 'Technical Masterclass',
      date: 'MAY 2024',
      description: 'Interactive masterclass on Linux command-line mastery, network security hygiene, and defensive tools for engineering freshmen.',
      impact: 'Over 100+ students set up their first Linux developer environments and security testbeds.',
      tags: ['Linux', 'Cybersecurity', 'Networking'],
      icon: '🛡️',
    ),
    ActivityModel(
      title: 'Community Code Jam & Project Mentorship',
      eventType: 'Community Initiative',
      date: 'ONGOING',
      description: 'Weekly collaborative peer code reviews, architecture discussions, and open-source project development sprints.',
      impact: 'Fostered 10+ inter-year project collaborations.',
      tags: ['Community', 'Code Review', 'Collaboration'],
      icon: '🤝',
    ),
  ];

  // Achievements & Badges
  static const List<AchievementModel> achievements = [
    AchievementModel(
      title: 'Hackathon Top Innovator Award',
      issuer: 'Inter-College Engineering Hackathon',
      date: '2024',
      description: 'Recognized for outstanding architecture, technical depth, and polished UI/UX in building an on-device cybersecurity monitoring tool.',
      category: 'Competition',
      badgeIcon: '🥇',
      skillsGained: ['Rapid Architecture', 'Security Engineering', 'Public Pitching'],
    ),
    AchievementModel(
      title: 'Google Developer Student Clubs Recognition',
      issuer: 'GDSC Chapter',
      date: '2024',
      description: 'Recognized for active contributions to mobile development tracks and peer mentoring sessions.',
      category: 'Community',
      badgeIcon: '🌟',
      skillsGained: ['Mobile Dev', 'Community Outreach'],
    ),
    AchievementModel(
      title: 'Linux System Administration & Security Certificate',
      issuer: 'Linux Foundation / Academic Track',
      date: '2024',
      description: 'Comprehensive certification covering Linux kernel fundamentals, shell scripting, permission models, and server hardening.',
      category: 'Certification',
      badgeIcon: '🐧',
      skillsGained: ['Linux Bash', 'Permissions', 'Hardening', 'Networking'],
    ),
    AchievementModel(
      title: 'Flutter & Dart Advanced Development Mastery',
      issuer: 'Professional Developer Credential',
      date: '2023',
      description: 'In-depth mastery in advanced state management, asynchronous streams, animations, and cross-platform native plugins.',
      category: 'Certification',
      badgeIcon: '📱',
      skillsGained: ['Riverpod', 'Custom Animations', 'Performance Tuning'],
    ),
  ];

  // Terminal Predefined Commands
  static const Map<String, String> terminalResponses = {
    'whoami': 'Dnyaneshwar Galkar — Computer Engineering Student & Developer | Flutter, Cybersecurity, Linux, APIs.',
    'help': 'Available commands: [whoami, about, skills, projects, vamint, achievements, contact, clear, matrix, easteregg, sudo]',
    'about': 'Computer Engineering student at SPPU passionate about high-performance Flutter mobile/desktop apps, network cybersecurity, and community building.',
    'skills': 'Flutter, Dart, Python, Java, C++, Linux, Cybersecurity, Network Security, Firebase, REST APIs, SQL, Git.',
    'projects': '• CyberShield Guard (Security Suite)\n• OmniFlow Task Ecosystem (Productivity)\n• NetSentinel IDS (Intrusion Detection)\n• VAMINT Connect (Community App)',
    'vamint': 'VAMINT is our core technical student community where I lead tech initiatives, conduct workshops, and build event software.',
    'achievements': '• Hackathon Top Innovator 2024\n• Linux System Administration Certified\n• 15+ Projects & 1200+ Git Commits',
    'contact': 'Email: dnyaneshwargalkar@gmail.com\nGitHub: https://github.com/dnyaneshwargalkar\nLinkedIn: https://linkedin.com/in/dnyaneshwargalkar',
    'sudo': 'Access granted. Welcome to root mode, developer.',
    'matrix': 'Wake up, Neo... The matrix has you. Follow the white rabbit.',
    'easteregg': '🎉 You found the hidden Easter egg! "Simplicity is prerequisite for reliability." — Edsger W. Dijkstra 🚀',
  };
}
