// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/ui/events/events_details_view.dart';
import 'package:gdsc_app/ui/events/events_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:gdsc_app/ui/events/components/event_attendees.dart';
import '../../../core/models/member.dart';
import '../../ui/events/components/event_signup_button.dart';

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
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Image.asset("./assets/images/BarLogo.png"),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Text(
                                "الفعاليات",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Column(
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
                            onPressed: () {
                              viewmodel.navigateToEvent(e);
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

class EventCard extends StatelessWidget {
  const EventCard({Key? key, required this.event, required this.onPressed})
      : super(key: key);
  final Event event;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFFBFDEF5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10, top: 15, left: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ClipOval(
                    child: Image.network(
                      event.instructorProfilePicture!,
                      width: 66,
                      height: 66,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        event.instructorName,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Row(
                children: [
                  Text(
                    "${DateHelper.getDate(event.startDate)}  -  حضوري",
                    style: TextStyle(
                        color: Color(0xFF666C74),
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Image.asset("./assets/images/Place Marker.png"),
                          // ignore: prefer_const_constructors
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 100,
                            child: Text(
                              "${EventsViewModel().locationEventName(event.location)}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(width: 20),
                  EventAttendees(
                    attendees: event.attendees,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: onPressed,
                child: EventsViewModel().getSignUpCardButton(event),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// Widget eventCard(Event event, Function() onPressed) {
//   return
// }
