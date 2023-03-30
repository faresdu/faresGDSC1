import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/ui/events/events_viewmodel.dart';
import 'package:stacked/stacked.dart';

class EventsView extends StatefulWidget {
  const EventsView({Key? key}) : super(key: key);

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventsViewModel>.reactive(
        viewModelBuilder: () => EventsViewModel(),
        onViewModelReady: (model) => model.getEvents(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(title: const Text('Events')),
            body: Column(
              children: viewmodel.events
                  .map(
                    (e) => EventCard(
                      event: e,
                      onPressed: () {
                        viewmodel.navigateToEvent(e);
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        });
  }
}

class EventCard extends StatelessWidget {
  const EventCard({Key? key, required this.event, required this.onPressed})
      : super(key: key);
  final Event event;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(event.title),
    );
  }
}
