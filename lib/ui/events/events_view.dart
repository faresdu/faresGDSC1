import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/events/events_viewmodel.dart';
import 'package:stacked/stacked.dart';

class EventsView extends StatelessWidget {
  const EventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventsViewModel>.reactive(
        viewModelBuilder: () => EventsViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(title: const Text('Events')),
          );
        });
  }
}
