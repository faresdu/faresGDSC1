import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/ui/Home/components/section_title.dart';

import 'activity_card.dart';

class FeaturedEvents extends StatelessWidget {
  const FeaturedEvents({
    super.key,
    required this.updateScreen,
    required this.navigateToEvent,
    required this.getSignUpButton,
    required this.events,
  });

  final void Function(int index) updateScreen;
  final void Function(Event event) navigateToEvent;
  final Widget Function(Event event) getSignUpButton;
  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SectionTitle(
        title: "الفعاليات",
        onPressed: () {
          updateScreen(4);
        },
      ),
      const SizedBox(height: 5),
      SizedBox(
          height: 215,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: events
                .map((e) => ActivityCard(
                    onTap: () {
                      navigateToEvent(e);
                    },
                    signUpButton: getSignUpButton(e),
                    event: e))
                .toList(),
          ))
    ]);
  }
}
