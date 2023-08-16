import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/events/components/event_participant.dart';
import 'package:gdsc_app/ui/events/event_participants/event_participants_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:stacked/stacked.dart';

class EventParticipantsView extends StatelessWidget {
  const EventParticipantsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventParticipantsViewModel>.reactive(
        viewModelBuilder: () => EventParticipantsViewModel(),
        onViewModelReady: (model) => model.getUsers(context),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: CustomAppBar(title: 'المشاركين'),
            body: BusyOverlay(
              isBusy: viewmodel.isBusy,
              child: Container(
                child: Column(
                  children: viewmodel.participants
                      .map((e) => EventParticipant(
                          member: e,
                          onPressed: () =>
                              viewmodel.navigateToUserProfile(e.id)))
                      .toList(),
                ),
              ),
            ),
          );
        });
  }
}
