import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';
import '../models/experience_model.dart';
import '../models/achievement_model.dart';
import '../models/activity_model.dart';
import '../models/resume_model.dart';
import '../models/stat_model.dart';
import '../models/contact_message_model.dart';

/// Central Reactive State Manager providing live CRUD updates across the entire portfolio
class PortfolioStateManager extends ChangeNotifier {
  late List<ProjectModel> _projects;
  late List<SkillModel> _skills;
  late List<ExperienceModel> _experiences;
  late List<AchievementModel> _achievements;
  late List<ActivityModel> _vamintActivities;
  late List<ResumeModel> _resumes;
  late List<StatModel> _stats;
  late List<ContactMessageModel> _messages;
  late String _bio1;
  late String _bio2;
  late String _tagline;

  PortfolioStateManager() {
    _initData();
  }

  void _initData() {
    _projects = List.from(PortfolioData.projects);
    _skills = List.from(PortfolioData.skills);
    _experiences = List.from(PortfolioData.experiences);
    _achievements = List.from(PortfolioData.achievements);
    _vamintActivities = List.from(PortfolioData.vamintActivities);
    _stats = List.from(PortfolioData.stats);
    _bio1 = PortfolioData.bioParagraph1;
    _bio2 = PortfolioData.bioParagraph2;
    _tagline = PortfolioData.tagline;

    // Initialize Multiple Resumes
    _resumes = [
      const ResumeModel(
        id: 'resume-flutter-lead',
        title: 'Flutter & Mobile Systems Engineer CV',
        roleFocus: 'Flutter / Dart / Android / Clean Architecture',
        lastUpdated: 'JAN 2025',
        url: PortfolioData.resumeUrl,
        fileSize: '168 KB',
        isPrimary: true,
        badge: 'PRIMARY',
        summaryPoints: [
          'Production mastery in Flutter custom render objects, Isolates, Riverpod, and Clean Architecture.',
          'Built CyberShield Guard & OmniFlow with background networking & offline-first Firestore synchronization.',
          'Core technical lead at VAMINT, orchestrating hackathon platforms for 600+ engineers.'
        ],
      ),
      const ResumeModel(
        id: 'resume-cyber-systems',
        title: 'Cybersecurity & Systems Engineering Resume',
        roleFocus: 'Linux Kernel / Packet Forensics / Network Security',
        lastUpdated: 'DEC 2024',
        url: PortfolioData.resumeUrl,
        fileSize: '152 KB',
        isPrimary: false,
        badge: 'SECURITY FOCUS',
        summaryPoints: [
          'Certified in Linux System Administration, shell scripting automation, and server hardening.',
          'Built NetSentinel IDS for real-time PCAP stream anomaly classification and ARP poisoning detection.',
          'Active participant in defensive cybersecurity CTFs and open-source vulnerability audits.'
        ],
      ),
      const ResumeModel(
        id: 'resume-fullstack-dev',
        title: 'Full-Stack Software Developer Comprehensive',
        roleFocus: 'Flutter / Python / REST APIs / Firebase / SQL',
        lastUpdated: 'NOV 2024',
        url: PortfolioData.resumeUrl,
        fileSize: '194 KB',
        isPrimary: false,
        badge: 'COMPREHENSIVE',
        summaryPoints: [
          'End-to-end software engineering across mobile clients, backend microservices, and relational databases.',
          '15+ standalone applications deployed, 1,200+ git commits, and multiple national hackathon awards.',
          'Strong computer science fundamentals in OS internals, algorithms, and database design.'
        ],
      ),
    ];

    // Seed Contact Inquiries
    _messages = [
      ContactMessageModel(
        id: 'msg-1',
        senderName: 'Sarah Jenkins',
        senderEmail: 'sarah.j@techcorp.io',
        subject: 'Mobile Systems Engineering Lead Opportunity',
        message: 'Hi Dnyaneshwar, your Flutter work on CyberShield Guard caught our eye. We would love to chat regarding our upcoming engineering program.',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isRead: false,
      ),
      ContactMessageModel(
        id: 'msg-2',
        senderName: 'Rohan Sharma',
        senderEmail: 'rohan.dev@startuphub.in',
        subject: 'Hackathon Collaboration / VAMINT',
        message: 'Hey Dnyaneshwar! Loved your talk at VAMINT. Are you open to collaborating on an upcoming security challenge project?',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
    ];
  }

  // Getters
  List<ProjectModel> get projects => List.unmodifiable(_projects);
  List<SkillModel> get skills => List.unmodifiable(_skills);
  List<ExperienceModel> get experiences => List.unmodifiable(_experiences);
  List<AchievementModel> get achievements => List.unmodifiable(_achievements);
  List<ActivityModel> get vamintActivities => List.unmodifiable(_vamintActivities);
  List<ResumeModel> get resumes => List.unmodifiable(_resumes);
  List<StatModel> get stats => List.unmodifiable(_stats);
  List<ContactMessageModel> get messages => List.unmodifiable(_messages);
  int get unreadMessagesCount => _messages.where((m) => !m.isRead).length;
  String get bio1 => _bio1;
  String get bio2 => _bio2;
  String get tagline => _tagline;

  // --- PROJECTS CRUD ---
  void addProject(ProjectModel project) {
    _projects.insert(0, project);
    notifyListeners();
  }

  void updateProject(String id, ProjectModel updatedProject) {
    final int index = _projects.indexWhere((p) => p.id == id);
    if (index != -1) {
      _projects[index] = updatedProject;
      notifyListeners();
    }
  }

  void deleteProject(String id) {
    _projects.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  // --- SKILLS CRUD ---
  void addSkill(SkillModel skill) {
    _skills.add(skill);
    notifyListeners();
  }

  void updateSkill(String name, SkillModel updatedSkill) {
    final int index = _skills.indexWhere((s) => s.name.toLowerCase() == name.toLowerCase());
    if (index != -1) {
      _skills[index] = updatedSkill;
      notifyListeners();
    }
  }

  void deleteSkill(String name) {
    _skills.removeWhere((s) => s.name.toLowerCase() == name.toLowerCase());
    notifyListeners();
  }

  // --- EXPERIENCES CRUD ---
  void addExperience(ExperienceModel experience) {
    _experiences.insert(0, experience);
    notifyListeners();
  }

  void deleteExperience(int index) {
    if (index >= 0 && index < _experiences.length) {
      _experiences.removeAt(index);
      notifyListeners();
    }
  }

  // --- ACHIEVEMENTS CRUD ---
  void addAchievement(AchievementModel achievement) {
    _achievements.insert(0, achievement);
    notifyListeners();
  }

  void deleteAchievement(int index) {
    if (index >= 0 && index < _achievements.length) {
      _achievements.removeAt(index);
      notifyListeners();
    }
  }

  // --- VAMINT ACTIVITIES CRUD ---
  void addVamintActivity(ActivityModel activity) {
    _vamintActivities.insert(0, activity);
    notifyListeners();
  }

  void deleteVamintActivity(int index) {
    if (index >= 0 && index < _vamintActivities.length) {
      _vamintActivities.removeAt(index);
      notifyListeners();
    }
  }

  // --- RESUMES CRUD ---
  void addResume(ResumeModel resume) {
    _resumes.add(resume);
    notifyListeners();
  }

  void updateResume(String id, ResumeModel updatedResume) {
    final int index = _resumes.indexWhere((r) => r.id == id);
    if (index != -1) {
      _resumes[index] = updatedResume;
      notifyListeners();
    }
  }

  void deleteResume(String id) {
    _resumes.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  // --- PROFILE & BIO UPDATES ---
  void updateBio({String? bio1, String? bio2, String? tagline}) {
    if (bio1 != null) _bio1 = bio1;
    if (bio2 != null) _bio2 = bio2;
    if (tagline != null) _tagline = tagline;
    notifyListeners();
  }

  // --- CONTACT MESSAGES / INQUIRIES CRUD ---
  void addMessage(ContactMessageModel message) {
    _messages.insert(0, message);
    notifyListeners();
  }

  void markMessageAsRead(String id) {
    final int index = _messages.indexWhere((m) => m.id == id);
    if (index != -1) {
      _messages[index] = _messages[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  void toggleMessageReadStatus(String id) {
    final int index = _messages.indexWhere((m) => m.id == id);
    if (index != -1) {
      _messages[index] = _messages[index].copyWith(isRead: !_messages[index].isRead);
      notifyListeners();
    }
  }

  void deleteMessage(String id) {
    _messages.removeWhere((m) => m.id == id);
    notifyListeners();
  }

  void clearAllMessages() {
    _messages.clear();
    notifyListeners();
  }
}
