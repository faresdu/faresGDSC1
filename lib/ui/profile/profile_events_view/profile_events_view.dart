import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/events/add_event/add_event_view.dart';
import 'package:gdsc_app/ui/events/components/events_card.dart';
import 'package:gdsc_app/ui/profile/profile_events_view/profile_events_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_bottom_modal_sheet.dart';
import 'package:gdsc_app/ui/widgets/circle_button.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/custom_tab_bar_controller.dart';
import 'package:stacked/stacked.dart';

class ProfileEventsView extends StatelessWidget {
  const ProfileEventsView({super.key});

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
              child: CustomTabBarController(
                length: viewmodel.user.isLeaderOrCoLeader() ? 2 : 1,
                tabs: [
                  const Tab(
                    text: 'المشارك بها',
                  ),
                  if (viewmodel.user.isLeaderOrCoLeader())
                    const Tab(
                      text: 'المنشأة',
                    ),
                ],
                button: viewmodel.isUser && viewmodel.user.isLeaderOrCoLeader()
                    ? CircleButton(
                        onPressed: () => CustomModalBottomSheet(
                            context, const AddEventView(),
                            heightFactor: 0.92))
                    : null,
                children: [
                  ListView(
                      children: viewmodel.signedUpEvents
                          .map((e) => EventCard(
                                event: e,
                                signUpButton: viewmodel.getSignUpButton(e),
                                canEdit: viewmodel.canEditEvent(e),
                                onPressed: () {
                                  viewmodel.navigateToEvent(e);
                                },
                              ))
                          .toList()),
                  if (viewmodel.user.isLeaderOrCoLeader())
                    ListView(
                        children: viewmodel.createdEvents
                            .map((e) => EventCard(
                                  event: e,
                                  signUpButton: viewmodel.getSignUpButton(e),
                                  canEdit: viewmodel.canEditEvent(e),
                                  onPressed: () {
                                    viewmodel.navigateToEvent(e);
                                  },
                                ))
                            .toList())
                ],
              ),
            ),
          );
        });
  }
}
