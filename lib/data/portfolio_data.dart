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

  // Featured Projects Case Studies
  static const List<ProjectModel> projects = [
    ProjectModel(
      id: 'cybershield-guard',
      title: 'CyberShield Guard',
      tagline: 'On-device network monitor & vulnerability scanner with live packet inspection.',
      description: 'A mobile-first cybersecurity suite built with Flutter and native Android bridging. Analyzes WiFi network vulnerabilities, detects ARP spoofing attacks, and scores local device security posture in real-time.',
      problem: 'Mobile users on public Wi-Fi networks are constantly vulnerable to man-in-the-middle attacks, DNS hijacking, and unauthorized device probing without having accessible diagnostic tools.',
      solution: 'Engineered an intuitive mobile application that performs background network telemetry, flags ARP poisoning attempts instantly, and provides actionable remediation guidance.',
      features: [
        'Real-time ARP spoofing & MITM attack detection engine',
        'Local port scanner and open port risk assessment',
        'Cryptographic hash verification tool for downloaded files',
        'Offline vulnerability signature database',
        'Dark cyber aesthetic with interactive latency & packet graphs'
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
    ProjectModel(
      id: 'omniflow-ecosystem',
      title: 'OmniFlow Task Ecosystem',
      tagline: 'Collaborative task & developer workflow manager with real-time cloud sync.',
      description: 'A full-scale productivity and milestone tracking desktop & mobile application featuring Kanban boards, Gantt timeline views, automated GitHub webhook synchronization, and offline-first persistence.',
      problem: 'Engineering student teams struggle with scattered project tools that lack lightweight developer integration and real-time collaboration.',
      solution: 'Built a unified workspace that bridges task tracking with GitHub activity, cloud Firestore real-time synchronization, and smooth drag-and-drop mechanics.',
      features: [
        'Fluid drag-and-drop Kanban board with custom physics',
        'Live multi-user collaboration with Cloud Firestore streams',
        'GitHub commit & pull-request linkage via webhooks',
        'Offline-first caching with automatic conflict resolution',
        'Custom interactive telemetry charts'
      ],
      technologies: ['Flutter', 'Dart', 'Firebase Firestore', 'Cloud Functions', 'REST APIs', 'Riverpod'],
      architecture: 'Riverpod-driven state management layer coupled with a repository pattern caching layer for offline resilience.',
      challenges: 'Handling optimistic UI updates with bi-directional multi-user concurrent edits.',
      learnings: 'Deepened mastery in stream architectures, state reconciliation, and Flutter desktop keyboard shortcut integration.',
      githubUrl: 'https://github.com/dnyaneshwargalkar/omniflow-app',
      liveDemoUrl: 'https://omniflow-demo.web.app',
      category: 'Mobile',
      isFeatured: true,
      iconSymbol: '⚡',
    ),
    ProjectModel(
      id: 'netsentinel-ids',
      title: 'NetSentinel IDS',
      tagline: 'Lightweight intrusion detection & network anomaly classifier.',
      description: 'A hybrid network traffic analyzer developed using Python backend processing with a Flutter desktop visualization frontend. Dissects live PCAP streams and flags abnormal traffic spikes.',
      problem: 'Enterprise intrusion detection systems are overly bloated and hard to configure for small lab environments and student sandboxes.',
      solution: 'Created a modular, portable intrusion detector with interactive visual rule configuration and instant desktop alerts.',
      features: [
        'Live PCAP stream parsing and packet header dissection',
        'Statistical anomaly threshold detection for SYN floods & port scans',
        'Custom rule builder for signature matching',
        'Exportable forensics reports in JSON and CSV format'
      ],
      technologies: ['Python', 'Flutter Desktop', 'Wireshark Libs', 'WebSockets', 'SQLite'],
      architecture: 'Client-server architecture communicating over local Unix domain sockets / WebSockets with decoupled telemetry workers.',
      challenges: 'Maintaining sub-millisecond parsing throughput during heavy packet bursts.',
      learnings: 'Gained profound insights into raw socket handling, OSI Layer 3/4 headers, and IPC performance.',
      githubUrl: 'https://github.com/dnyaneshwargalkar/netsentinel-ids',
      category: 'Cybersecurity',
      isFeatured: true,
      iconSymbol: '🛰️',
    ),
    ProjectModel(
      id: 'datalens-analytics',
      title: 'DataLens Analytics',
      tagline: 'Interactive dataset exploration & automated visual reporting toolkit.',
      description: 'A desktop application engineered for rapid exploratory data analysis (EDA), generating instant statistical summaries, correlation heatmaps, and outlier detection.',
      problem: 'Non-technical stakeholders and early engineering students find raw dataset exploration in code notebooks cumbersome to share and inspect.',
      solution: 'Developed an interactive drag-and-drop dataset visualizer that instantly charts distribution curves, missing value matrices, and correlation grids.',
      features: [
        'Drag-and-drop CSV & JSON ingestion with automatic type inference',
        'Interactive correlation matrices and distribution histograms',
        'Automated outlier detection using IQR and Z-score methods',
        'Exportable high-resolution vector charts'
      ],
      technologies: ['Flutter Desktop', 'Dart', 'Python Engine', 'CustomPainter', 'Data Science'],
      architecture: 'Modular pipeline with data transformation microservices and CustomPainter chart engines.',
      challenges: 'Rendering tens of thousands of data points smoothly without frame drops.',
      learnings: 'Engineered hardware-accelerated Canvas batch rendering and optimized data buffer structures.',
      githubUrl: 'https://github.com/dnyaneshwargalkar/datalens-analytics',
      category: 'AI / Data',
      isFeatured: false,
      iconSymbol: '📊',
    ),
    ProjectModel(
      id: 'vamint-connect',
      title: 'VAMINT Community App',
      tagline: 'Official event management & hackathon companion app for the VAMINT club.',
      description: 'A comprehensive event ecosystem for students to register for hackathons, form teams, submit projects, access workshop slide decks, and receive real-time schedule notifications.',
      problem: 'Coordinating multi-day technical club events through scattered Google Forms and Discord channels causes high friction.',
      solution: 'Built a unified Flutter mobile application with QR-code event check-ins, automated team matchmaking, and live announcement feeds.',
      features: [
        'Fast QR Code ticketing and on-site check-in scanner',
        'Live hackathon countdown timer and submission portal',
        'Interactive community discussion boards',
        'Push notifications for critical schedule changes'
      ],
      technologies: ['Flutter', 'Firebase Auth', 'Firestore', 'FCM', 'QR Scanner'],
      architecture: 'Layered architecture with offline persistence and cloud functions automating attendee certificate generation.',
      challenges: 'Ensuring seamless offline event check-in when venue WiFi experienced intermittent dropouts.',
      learnings: 'Implemented robust local SQLite event caching with background reconciliation sync.',
      githubUrl: 'https://github.com/dnyaneshwargalkar/vamint-connect-app',
      category: 'Mobile',
      isFeatured: true,
      iconSymbol: '🌟',
    ),
  ];

  // Experience & Milestones Timeline
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
    ExperienceModel(
      title: 'Hackathon Finalist & Lead Builder',
      organization: 'National College Hackathons',
      period: '2024',
      roleType: 'Hackathon',
      description: 'Engineered rapid functional prototypes in 24-36 hour continuous hackathons, focusing on cybersecurity tools and smart utility apps.',
      highlights: [
        'Built an end-to-end prototype for decentralized student verification in under 30 hours.',
        'Demonstrated live product architecture and technical pitch to enterprise jury panels.',
        'Ranked in top 5% among 120+ competing engineering teams nationwide.'
      ],
      tags: ['Rapid Prototyping', 'Team Leadership', 'Pitching', 'Agile'],
      icon: '🏆',
    ),
    ExperienceModel(
      title: 'Cybersecurity & Open Source Contributor',
      organization: 'Open Source Community',
      period: '2023 — Present',
      roleType: 'Open Source',
      description: 'Auditing security tools, contributing documentation fixes, and publishing reusable Flutter and Dart utility packages.',
      highlights: [
        'Contributed security hardening patches and documentation to open-source developer repositories.',
        'Authored open-source Flutter boilerplates with clean architecture and reactive state management.',
        'Active participant in Linux system administration and cybersecurity Capture The Flag (CTF) challenges.'
      ],
      tags: ['Open Source', 'Security Audits', 'Git', 'Linux', 'Dart Packages'],
      icon: '🛡️',
    ),
    ExperienceModel(
      title: 'Computer Engineering Scholar',
      organization: 'Department of Computer Engineering',
      period: '2023 — 2027',
      roleType: 'Academic',
      description: 'Deep diving into core computer science foundations: Data Structures & Algorithms, Operating Systems, Computer Networks, and DBMS.',
      highlights: [
        'Maintained high academic standing with strong coursework in OS internals, Networks, and Object-Oriented Design.',
        'Built laboratory simulation tools for memory allocation algorithms and CPU scheduling in C++.',
        'Selected as student coordinator for departmental technical exhibitions.'
      ],
      tags: ['Data Structures', 'Operating Systems', 'Computer Networks', 'Algorithms'],
      icon: '🎓',
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
