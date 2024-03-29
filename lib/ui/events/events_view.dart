import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/events/add_event/add_event_view.dart';
import 'package:gdsc_app/ui/events/events_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/custom_bottom_modal_sheet.dart';
import 'package:stacked/stacked.dart';

import '../widgets/custom_tab_bar_controller.dart';

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
            floatingActionButton: viewmodel.isAdmin()
                ? FloatingActionButton(
                    onPressed: () {
                      CustomModalBottomSheet(context, const AddEventView(),
                          heightFactor: 0.92);
                    },
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  )
                : null,
            appBar: CustomAppBar(
              title: "الفعاليات",
              leading: Image.asset(
                "./assets/images/GDSC/GDSC.png",
              ),
              leadingWidth: 100,
            ),
            body: SafeArea(
              child: viewmodel.isAdmin()
                  ? CustomTabBarController(
                      length: 2,
                      tabs: const [
                        Tab(text: 'الفعاليات الجديدة'),
                        Tab(text: 'جميع الفعاليات'),
                      ],
                      children: [
                        ListView(
                          children: viewmodel.getNewCards(context),
                        ),
                        ListView(
                          children: viewmodel.getAllCards(context),
                        ),
                      ],
                    )
                  : ListView(
                      children: viewmodel.getNewCards(context),
                    ),
            ),
          );
        });
  }
}
