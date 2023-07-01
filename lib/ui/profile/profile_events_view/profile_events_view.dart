import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/events/add_event/add_event_view.dart';
import 'package:gdsc_app/ui/events/components/events_card.dart';
import 'package:gdsc_app/ui/profile/profile_events_view/profile_events_viewmodel.dart';
import 'package:gdsc_app/ui/profile/profile_user_hours/profile_request_hours_view.dart';
import 'package:gdsc_app/ui/widgets/bottom_sheet_post.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/circle_button.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/custom_bottom_sheet.dart';
import 'package:stacked/stacked.dart';

class ProfileEventsView extends StatelessWidget {
  const ProfileEventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileEventsViewModel>.reactive(
        viewModelBuilder: () => ProfileEventsViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: 'الفعاليات',
            ),
            backgroundColor: Constants.background,
            body: SafeArea(
              child: DefaultTabController(
                length: 2,
                key: GlobalKey(debugLabel: 'profile_events'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                boxShadow: Constants.shadow3,
                                color: Constants.white,
                                borderRadius: BorderRadius.circular(25)),
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TabBar(
                              unselectedLabelStyle: Constants.smallText
                                  .copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                              labelStyle: Constants.smallText.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              unselectedLabelColor: Colors.black,
                              indicator: BoxDecoration(
                                  color: Constants.blueButton,
                                  borderRadius: BorderRadius.circular(25)),
                              tabs: const <Widget>[
                                Tab(
                                  text: 'المشارك بها',
                                ),
                                Tab(
                                  text: 'المنشأه',
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          CircleButton(
                              onPressed: () => getCustomBottomSheet(
                                  context, const AddEventView()))
                        ],
                      ),
                    ),
                    Expanded(
                        child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                              children: viewmodel.signedUpEvents
                                  .map((e) => EventCard(
                                        event: e,
                                        signUpButton:
                                            viewmodel.getSignUpButton(e),
                                        canEdit: viewmodel.canEditEvent(e),
                                        onPressed: () {
                                          viewmodel.navigateToEvent(e);
                                        },
                                      ))
                                  .toList()),
                        ),
                        SingleChildScrollView(
                          child: Column(
                              children: viewmodel.createdEvents
                                  .map((e) => EventCard(
                                        event: e,
                                        signUpButton:
                                            viewmodel.getSignUpButton(e),
                                        canEdit: true,
                                        onPressed: () {
                                          viewmodel.navigateToEvent(e);
                                        },
                                      ))
                                  .toList()),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
