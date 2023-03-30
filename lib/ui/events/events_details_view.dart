import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:stacked/stacked.dart';
import '../../core/utils/constants.dart';
import 'components/event_attendees.dart';
import 'components/event_date_box.dart';
import 'components/event_info_box.dart';
import 'components/event_signup_button.dart';
import 'events_viewmodel.dart';

TextStyle titleStyle =
    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700);

class EventsDetailsView extends StatelessWidget {
  const EventsDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventsViewModel>.reactive(
        viewModelBuilder: () => EventsViewModel(),
        onViewModelReady: (model) => model.getEvent(context),
        builder: (context, viewmodel, _) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(viewmodel.eventDetails.flyer ??
                        'https://hackr.io/blog/best-way-to-learn-java/thumbnail/large'),
                    Text(
                      viewmodel.eventDetails.title,
                      style: titleStyle,
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
                          bottomText:
                              '${DateHelper.getHour(viewmodel.eventDetails.startDate)} - ${DateHelper.getHour(viewmodel.eventDetails.endDate)}',
                        ),
                        EventInfoBox(
                            topText: 'الموقع',
                            bottomText: viewmodel.eventDetails.location),
                        EventInfoBox(
                            topText: 'المحاضر',
                            bottomText: viewmodel.eventDetails.instructor)
                      ],
                    ),
                    Divider(
                      height: 1,
                      color: Constants.grey.withOpacity(.5),
                    ),
                    Text(
                      'عن الفعالية',
                      style: titleStyle,
                    ),
                    Text(
                      viewmodel.eventDetails.description ?? 'لا يوجد وصف',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Constants.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        EventSignupButton(onPressed: () {}),
                        EventAttendees(
                          remainingSeats: viewmodel.eventDetails.maxAttendees -
                              viewmodel.eventDetails.numAttendees,
                          attendees: viewmodel.eventDetails.attendees,
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
}
