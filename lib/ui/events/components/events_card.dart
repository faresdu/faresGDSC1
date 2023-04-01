import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:gdsc_app/ui/events/components/event_attendees.dart';
import 'package:gdsc_app/ui/events/events_viewmodel.dart';

class EventCard extends StatelessWidget {
  const EventCard({Key? key, required this.event, required this.onPressed, required this.signUpButton})
      : super(key: key);
  final Event event;
  final Function() onPressed;
  final Widget signUpButton;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 240,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFFBFDEF5),
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
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          event.instructorName,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Row(
                  children: [
                    Text(
                      "${DateHelper.getDate(event.startDate)}  -  حضوري",
                      style: const TextStyle(
                          color: Color(0xFF666C74),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
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
                                EventsViewModel.locationEventName(event.location),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(width: 20),
                    EventAttendees(
                      attendees: event.attendees,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: signUpButton,
              )
            ],
          ),
        ),
      ),
    );
  }
}
