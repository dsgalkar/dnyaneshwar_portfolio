import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../data/portfolio_data.dart';
import '../common/glass_container.dart';

class _TerminalEntry {
  final String prompt;
  final String command;
  final String output;

  _TerminalEntry({
    required this.prompt,
    required this.command,
    required this.output,
  });
}

/// Interactive Cyber Terminal Emulator with command processor and history
class InteractiveTerminal extends StatefulWidget {
  final VoidCallback? onTriggerMatrix;
  final VoidCallback? onTriggerEasterEgg;
  final VoidCallback? onTriggerLogin;

  const InteractiveTerminal({
    super.key,
    this.onTriggerMatrix,
    this.onTriggerEasterEgg,
    this.onTriggerLogin,
  });

  @override
  State<InteractiveTerminal> createState() => _InteractiveTerminalState();
}

class _InteractiveTerminalState extends State<InteractiveTerminal> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  final List<_TerminalEntry> _history = [
    _TerminalEntry(
      prompt: 'dnyaneshwar@portfolio:~\$ ',
      command: 'whoami',
      output: PortfolioData.terminalResponses['whoami']!,
    ),
    _TerminalEntry(
      prompt: 'dnyaneshwar@portfolio:~\$ ',
      command: 'help',
      output: PortfolioData.terminalResponses['help']!,
    ),
  ];

  void _handleCommand(String rawInput) {
    final String cmd = rawInput.trim().toLowerCase();
    _textController.clear();

    if (cmd.isEmpty) return;

    if (cmd == 'clear') {
      setState(() {
        _history.clear();
      });
      return;
    }

    if (cmd == 'matrix' && widget.onTriggerMatrix != null) {
      widget.onTriggerMatrix!();
    }

    if (cmd == 'easteregg' && widget.onTriggerEasterEgg != null) {
      widget.onTriggerEasterEgg!();
    }

    if ((cmd == 'admin' || cmd == 'login' || cmd == 'auth') && widget.onTriggerLogin != null) {
      widget.onTriggerLogin!();
      setState(() {
        _history.add(
          _TerminalEntry(
            prompt: 'dnyaneshwar@portfolio:~\$ ',
            command: rawInput.trim(),
            output: 'Opening Admin Authentication Dialog...',
          ),
        );
      });
      return;
    }

    final String output = PortfolioData.terminalResponses[cmd] ??
        'command not found: $cmd. Type "help" to see available commands.';

    setState(() {
      _history.add(
        _TerminalEntry(
          prompt: 'dnyaneshwar@portfolio:~\$ ',
          command: rawInput.trim(),
          output: output,
        ),
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: EdgeInsets.zero,
      color: AppColors.terminalBg.withValues(alpha: 0.95),
      borderColor: AppColors.cyan.withValues(alpha: 0.35),
      borderRadius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Mac/Linux Terminal Window Top Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated.withValues(alpha: 0.8),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              border: const Border(bottom: BorderSide(color: AppColors.surfaceGlassBorder)),
            ),
            child: Row(
              children: [
                Row(
                  children: [
                    Container(width: 12, height: 12, decoration: const BoxDecoration(color: Color(0xFFFF5F56), shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Container(width: 12, height: 12, decoration: const BoxDecoration(color: Color(0xFFFFBD2E), shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Container(width: 12, height: 12, decoration: const BoxDecoration(color: Color(0xFF27C93F), shape: BoxShape.circle)),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'bash — dnyaneshwar@portfolio: ~ (interactive)',
                    style: AppTypography.codeFont(color: AppColors.textMuted, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Terminal Output Stream & Command Input
          Container(
            height: 280,
            padding: const EdgeInsets.all(16),
            child: ListView(
              controller: _scrollController,
              children: [
                for (final item in _history) ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.prompt, style: AppTypography.codeFont(color: AppColors.terminalGreen, fontSize: 13, fontWeight: FontWeight.w700)),
                      Expanded(
                        child: Text(item.command, style: AppTypography.codeFont(color: AppColors.textPrimary, fontSize: 13)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
                    child: Text(
                      item.output,
                      style: AppTypography.codeFont(
                        color: AppColors.cyan.withValues(alpha: 0.9),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],

                // Live Input Row
                Row(
                  children: [
                    Text('dnyaneshwar@portfolio:~\$ ', style: AppTypography.codeFont(color: AppColors.terminalGreen, fontSize: 13, fontWeight: FontWeight.w700)),
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        focusNode: _focusNode,
                        style: AppTypography.codeFont(color: Colors.white, fontSize: 13),
                        cursorColor: AppColors.cyan,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          fillColor: Colors.transparent,
                        ),
                        onSubmitted: _handleCommand,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
