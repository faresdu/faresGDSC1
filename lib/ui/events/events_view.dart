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
            floatingActionButton: viewmodel.isAdmin()
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
              leading: Image.asset(
                "./assets/images/GDSC/GDSC.png",
              ),
              leadingWidth: 100,
            ),
            body: SafeArea(
              child: DefaultTabController(
                length: viewmodel.isAdmin() ? 2 : 1,
                child: Column(children: [
                  if (viewmodel.isAdmin())
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 10),
                      decoration: BoxDecoration(
                          boxShadow: Constants.shadow3,
                          color: Constants.white,
                          borderRadius: BorderRadius.circular(25)),
                      width: MediaQuery.of(context).size.width * 0.93,
                      child: TabBar(
                        unselectedLabelStyle: Constants.smallText.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w700),
                        labelStyle: Constants.smallText.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                            color: Constants.blueButton,
                            borderRadius: BorderRadius.circular(25)),
                        tabs: const <Widget>[
                          Tab(text: 'الفعاليات الجديدة'),
                          Tab(text: 'جميع الفعاليات'),
                        ],
                      ),
                    ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        ListView(
                          children: viewmodel.getNewCards(),
                        ),
                        if (viewmodel.isAdmin())
                          ListView(
                            children: viewmodel.getAllCards(),
                          ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          );
        });
  }
}
