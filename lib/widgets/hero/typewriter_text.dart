import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Animated rotating typewriter text with blinking terminal cursor
class TypewriterText extends StatefulWidget {
  final List<String> texts;
  final TextStyle? style;
  final Duration typingSpeed;
  final Duration pauseDuration;

  const TypewriterText({
    super.key,
    required this.texts,
    this.style,
    this.typingSpeed = const Duration(milliseconds: 70),
    this.pauseDuration = const Duration(milliseconds: 1800),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> with SingleTickerProviderStateMixin {
  int _currentTextIndex = 0;
  String _displayedText = '';
  int _charIndex = 0;
  bool _isDeleting = false;
  Timer? _timer;
  late AnimationController _cursorBlinkController;

  @override
  void initState() {
    super.initState();
    _cursorBlinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.typingSpeed, (timer) {
      final String fullText = widget.texts[_currentTextIndex];

      if (!_isDeleting) {
        if (_charIndex < fullText.length) {
          _charIndex++;
          setState(() {
            _displayedText = fullText.substring(0, _charIndex);
          });
        } else {
          // Finished typing word, pause then delete
          _timer?.cancel();
          Future.delayed(widget.pauseDuration, () {
            if (mounted) {
              _isDeleting = true;
              _startTyping();
            }
          });
        }
      } else {
        if (_charIndex > 0) {
          _charIndex--;
          setState(() {
            _displayedText = fullText.substring(0, _charIndex);
          });
        } else {
          // Finished deleting, move to next word
          _isDeleting = false;
          _currentTextIndex = (_currentTextIndex + 1) % widget.texts.length;
          _timer?.cancel();
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              _startTyping();
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cursorBlinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.cyan, AppColors.blue],
          ).createShader(bounds),
          child: Text(
            _displayedText,
            style: widget.style ?? AppTypography.heroSubHeading,
          ),
        ),
        FadeTransition(
          opacity: _cursorBlinkController,
          child: Text(
            ' |',
            style: (widget.style ?? AppTypography.heroSubHeading).copyWith(
              color: AppColors.cyan,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
