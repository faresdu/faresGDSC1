import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/events/add_event/add_event_view.dart';
import 'package:gdsc_app/ui/events/events_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_bottom_modal_sheet.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
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
        builder: (context, viewmodel, _) {
          return Scaffold(
            backgroundColor: Constants.background,
            floatingActionButton: viewmodel.user.isLeaderOrCoLeader()
                ? FloatingActionButton(
                    onPressed: () {
                      CustomModalBottomSheet(context, const AddEventView(),
                          heightFactor: 0.92);
                    },
                    backgroundColor: Constants.blueButton,
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  )
                : null,
            appBar: CustomAppBar(
              title: "الفعاليات",
              leading: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  "./assets/images/BarLogo.png",
                ),
              ),
              leadingWidth: 100,
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(children: [
                  if (viewmodel.canSeeOldEvents())
                    TextButton(
                      onPressed: () {
                        viewmodel.switchFilter();
                      },
                      child: Text(viewmodel.filtered
                          ? 'see all events'
                          : 'see new events'),
                    ),
                  Column(
                    children: viewmodel.getCards(),
                  )
                ]),
              ),
            ),
          );
        });
  }
}
