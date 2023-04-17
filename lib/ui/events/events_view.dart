// ignore_for_file: prefer_const_constructors
import 'package:gdsc_app/ui/events/components/events_card.dart';
import 'package:flutter/material.dart';
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
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Image.asset("./assets/images/BarLogo.png"),
                        ),
                      ],
                    ),
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Text(
                            "الفعاليات",
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: const [
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
