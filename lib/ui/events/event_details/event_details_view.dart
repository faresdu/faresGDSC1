import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:stacked/stacked.dart';
import '../../../core/utils/constants.dart';
import '../components/event_attendees.dart';
import 'event_details_viewmodel.dart';

TextStyle titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, height: 3);

class EventDetailsView extends StatefulWidget {
  final Event event;

  const EventDetailsView({Key? key, required this.event}) : super(key: key);

  @override
  State<EventDetailsView> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventsDetailsViewModel>.reactive(
        viewModelBuilder: () => EventsDetailsViewModel(widget.event),
        builder: (context, viewmodel, _) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: viewmodel.eventDetails.flyer != null
                            ? Image.network(
                                viewmodel.eventDetails.flyer!,
                                fit: BoxFit.contain,
                              )
                            : Image.asset('assets/images/temp-events-img.png'),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        viewmodel.eventDetails.title,
                        style: titleStyle,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildEventDateBox(
                          day: viewmodel.eventDetails.startDate.day,
                          month: DateHelper.getMonth(viewmodel.eventDetails.startDate),
                        ),
                        buildEventInfoBox(
                          topText: DateHelper.getWeekDay(viewmodel.eventDetails.startDate),
                          bottomText: viewmodel.eventDetails.endDate != null
                              ? '${DateHelper.getHour(viewmodel.eventDetails.startDate)} - ${DateHelper.getHour(viewmodel.eventDetails.endDate!)}'
                              : DateHelper.getHour(viewmodel.eventDetails.startDate),
                        ),
                        buildEventInfoBox(topText: 'الموقع', bottomText: viewmodel.eventDetails.location),
                        buildEventInfoBox(topText: 'المحاضر', bottomText: viewmodel.eventDetails.host ?? viewmodel.eventDetails.instructorName)
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Divider(
                        height: 1,
                        color: Constants.grey.withOpacity(.5),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Text(
                        'عن الفعالية',
                        style: titleStyle,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        viewmodel.eventDetails.description ?? 'لا يوجد وصف',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Constants.grey),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        viewmodel.getSignUpButton(viewmodel.eventDetails),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EventAttendees(
                              attendees: viewmodel.eventDetails.attendees,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Text(
                                'المقاعد المتبقية ${viewmodel.eventDetails.getRemainingSeats()}',
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Constants.grey),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildEventInfoBox({
    required String topText,
    required String bottomText,
    Function()? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Text(
            topText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(bottomText, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Constants.grey))
        ],
      ),
    );
  }

  Widget buildEventDateBox({
    required int day,
    required String month,
  }) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(13),
        ),
        color: Constants.grey.withOpacity(.1),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(children: [
          Text(
            '$day',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, height: 1),
          ),
          Text(
            month,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, height: 1),
          )
        ]),
      ),
    );
  }
}
