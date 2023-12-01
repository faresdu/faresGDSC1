import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/events/add_event/add_event_view.dart';
import 'package:gdsc_app/ui/events/components/events_card.dart';
import 'package:gdsc_app/ui/profile/profile_events_view/profile_events_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_bottom_modal_sheet.dart';
import 'package:gdsc_app/ui/widgets/circle_button.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/custom_tab_bar.dart';
import 'package:stacked/stacked.dart';

class ProfileEventsView extends StatelessWidget {
  const ProfileEventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileEventsViewModel>.reactive(
        viewModelBuilder: () => ProfileEventsViewModel(context),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: 'الفعاليات',
            ),
            backgroundColor: Constants.background,
            body: SafeArea(
              child: DefaultTabController(
                length: viewmodel.user.isLeaderOrCoLeader() ? 2 : 1,
                key: viewmodel.key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTapBar(
                        tabs: [
                          const Tab(
                            text: 'المشارك بها',
                          ),
                          if (viewmodel.user.isLeaderOrCoLeader())
                            const Tab(
                              text: 'المنشأة',
                            ),
                        ],
                        widget: viewmodel.isUser &&
                                viewmodel.user.isLeaderOrCoLeader()
                            ? CircleButton(
                                onPressed: () => CustomModalBottomSheet(
                                    context, const AddEventView(),
                                    heightFactor: 0.92))
                            : null),
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
                        if (viewmodel.user.isLeaderOrCoLeader())
                          SingleChildScrollView(
                            child: Column(
                                children: viewmodel.createdEvents
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
