import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:stacked/stacked.dart';
import '../../core/utils/constants.dart';
import 'components/event_attendees.dart';
import 'components/event_date_box.dart';
import 'components/event_info_box.dart';
import 'event_details_viewmodel.dart';

TextStyle titleStyle =
    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, height: 3);

class EventsDetailsView extends StatefulWidget {
  final Event event;
  const EventsDetailsView({Key? key, required this.event}) : super(key: key);

  @override
  State<EventsDetailsView> createState() => _EventsDetailsViewState();
}

class _EventsDetailsViewState extends State<EventsDetailsView> {
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
                        decoration: BoxDecoration(
                          color: Constants.grey.withOpacity(.05),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: viewmodel.eventDetails.flyer != null
                            ? Image.network(
                                viewmodel.eventDetails.flyer!,
                                fit: BoxFit.contain,
                              )
                            : Image.asset('assets/images/temp-events-img.png'),
                      ),
                    ),
                    Expanded(
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
                        EventDateBox(
                          day: viewmodel.eventDetails.startDate.day,
                          month: DateHelper.getMonth(
                              viewmodel.eventDetails.startDate),
                        ),
                        EventInfoBox(
                          topText: DateHelper.getWeekDay(
                              viewmodel.eventDetails.startDate),
                          bottomText: viewmodel.eventDetails.endDate != null
                              ? '${DateHelper.getHour(viewmodel.eventDetails.startDate)} - ${DateHelper.getHour(viewmodel.eventDetails.endDate!)}'
                              : DateHelper.getHour(
                                  viewmodel.eventDetails.startDate),
                        ),
                        EventInfoBox(
                            topText: 'الموقع',
                            bottomText: viewmodel.eventDetails.location),
                        EventInfoBox(
                            topText: 'المحاضر',
                            bottomText: viewmodel.eventDetails.host ??
                                viewmodel.eventDetails.instructorName)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Divider(
                        height: 1,
                        color: Constants.grey.withOpacity(.5),
                      ),
                    ),
                    Expanded(
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
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Constants.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                      child: Row(
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
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Constants.grey),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
