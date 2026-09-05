import 'package:flutter/material.dart';
import '../../core/animations/reveal_animation.dart';
import '../../models/experience_model.dart';
import 'glowing_timeline_item.dart';

/// Full Experience and Timeline Section list with dynamic reactive items
class ExperienceTimeline extends StatelessWidget {
  final List<ExperienceModel> experiences;

  const ExperienceTimeline({super.key, required this.experiences});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(experiences.length, (index) {
        final exp = experiences[index];
        final bool isLast = index == experiences.length - 1;

        return RevealAnimation(
          delay: Duration(milliseconds: 100 * index),
          child: GlowingTimelineItem(
            experience: exp,
            isLast: isLast,
          ),
        );
      }),
    );
  }
}
