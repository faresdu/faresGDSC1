import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import 'package:gdsc_app/ui/events/add_event/edit_event_view.dart';
import 'package:gdsc_app/ui/events/components/event_attendees.dart';
import 'package:gdsc_app/ui/events/events_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_bottom_modal_sheet.dart';

import '../../../core/utils/constants.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    Key? key,
    required this.event,
    required this.onPressed,
    required this.signUpButton,
    required this.canEdit,
  }) : super(key: key);
  final Event event;
  final Function() onPressed;
  final Widget signUpButton;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          fixedSize: const Size.fromWidth(double.maxFinite),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 3,
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: Constants.shadow,
                      ),
                      child: HelperFunctions.profileImage(
                          imageUrl: event.instructorProfilePicture ?? '',
                          width: 66,
                          height: 66,
                          gender: event.gender ?? "")),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width *
                              (canEdit ? 0.45 : 0.56),
                          child: Text(
                            event.title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Constants.black,
                            ),
                          ),
                        ),
                        Text(
                          event.instructorName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Constants.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (canEdit)
                    Flexible(
                      child: Align(
                        alignment: const Alignment(-1, 0),
                        child: IconButton(
                          onPressed: () {
                            CustomModalBottomSheet(
                                context, EditEventView(eventDetails: event),
                                heightFactor: 0.92);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Constants.black,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "${DateHelper.getDate(event.startDate)}  -  ${event.isOnline ? "اونلاين" : "حضوري"}",
                        style: const TextStyle(
                          color: Constants.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Image.asset(
                                    "./assets/icons/events/Place Marker.png"),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  EventsViewModel.locationEventName(
                                      event.location),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Constants.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: EventAttendees(
                            attendees: event.attendees,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              signUpButton
            ],
          ),
        ),
      ),
    );
  }
}
