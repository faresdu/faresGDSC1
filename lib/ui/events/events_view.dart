import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/events/add_new_event.dart';
import 'package:gdsc_app/ui/events/components/events_card.dart';
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
        builder: (context, viewmodel, _) {
          return Scaffold(
            backgroundColor: Constants.grayBackGround,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: const Color(0xffF1F1F1),
                  clipBehavior: Clip.antiAlias,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                  ),
                  builder: (context) {
                    return const FractionallySizedBox(
                        heightFactor: 0.92, child: AddEventView());
                  },
                );
              },
              backgroundColor: Constants.blueButton,
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Image.asset("./assets/images/BarLogo.png"),
                        ),
                        const Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Text(
                                "الفعاليات",
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        const Column(
                          children: [
                            SizedBox(
                              width: 110,
                            )
                          ],
                        ),
                      ]),
                  Column(
                    children: viewmodel.events
                        .map(
                          (e) => EventCard(
                            event: e,
                            signUpButton: viewmodel.getSignUpButton(e),
                            canEdit: viewmodel.canEditEvent(e),
                            onPressed: () {
                              viewmodel.navigateToEvent(context, e);
                            },
                          ),
                        )
                        .toList(),
                  )
                ]),
              ),
            ),
          );
        });
  }
}
