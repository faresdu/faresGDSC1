import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:gdsc_app/ui/widgets/submit_button.dart';
import 'package:stacked/stacked.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/helper_functions.dart';
import '../components/event_attendees.dart';
import 'event_details_viewmodel.dart';

TextStyle titleStyle =
    const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, height: 3);

class EventDetailsView extends StatefulWidget {
  const EventDetailsView({Key? key}) : super(key: key);

  @override
  State<EventDetailsView> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventsDetailsViewModel>.reactive(
        viewModelBuilder: () => EventsDetailsViewModel(),
        onViewModelReady: (model) => model.setEvent(context),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Constants.white,
              elevation: 0,
              foregroundColor: Constants.black,
              actions: [
                if (viewmodel.isOwner)
                  Container(
                      width: 160,
                      padding: const EdgeInsets.all(8),
                      child: SubmitButton(
                          text: 'معلومات المشاركين',
                          outlined: true,
                          onPressed: () =>
                              viewmodel.navigateToEventParticipants())),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: HelperFunctions.eventImage(
                          imageUrl: viewmodel.eventDetails.flyer,
                          fit: BoxFit.contain,
                        ),
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
                        BuildEventDateBox(
                            day: viewmodel.eventDetails.startDate.day,
                            month: DateHelper.getMonth(
                                viewmodel.eventDetails.startDate)),
                        buildEventInfoBox(
                          topText: DateHelper.getWeekDay(
                              viewmodel.eventDetails.startDate),
                          bottomText: viewmodel.eventDetails.endDate != null
                              ? '${DateHelper.getHour(viewmodel.eventDetails.startDate)} - ${DateHelper.getHour(viewmodel.eventDetails.endDate!)}'
                              : DateHelper.getHour(
                                  viewmodel.eventDetails.startDate),
                        ),
                        buildEventInfoBox(
                            topText: 'الموقع',
                            link: viewmodel.eventDetails.locationLink,
                            bottomText: viewmodel.eventDetails.location),
                        buildEventInfoBox(
                            topText: 'المحاضر',
                            bottomText: viewmodel.eventDetails.host ??
                                viewmodel.eventDetails.instructorName)
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
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
                      child: SingleChildScrollView(
                        child: Text(
                          viewmodel.eventDetails.description ?? 'لا يوجد وصف',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Constants.grey),
                        ),
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
    String? link,
    Function()? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Text(
            topText,
            style: Constants.verySmallText.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (link != null)
            InkWell(
              onTap: () async {
                HelperFunctions.openUrl(link);
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 1),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Constants.blue,
                  width: 2, // Underline thickness
                ))),
                child: Text(
                  bottomText,
                  style: Constants.extraSmallText.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Constants.blue,
                      height: 1.5),
                ),
              ),
            )
          else
            Text(bottomText,
                style: Constants.extraSmallText.copyWith(
                    fontWeight: FontWeight.bold, color: Constants.grey))
        ],
      ),
    );
  }
}

class BuildEventDateBox extends StatelessWidget {
  const BuildEventDateBox({
    super.key,
    required this.day,
    required this.month,
  });

  final int day;
  final String month;

  @override
  Widget build(BuildContext context) {
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
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, height: 1),
          ),
          Text(
            month,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, height: 1),
          )
        ]),
      ),
    );
  }
}
