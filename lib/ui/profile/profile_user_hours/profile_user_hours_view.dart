import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/profile/components/profile_volunteer_hours_card_big.dart';
import 'package:gdsc_app/ui/profile/profile_user_hours/profile_request_hours_view.dart';
import 'package:gdsc_app/ui/profile/profile_user_hours/profile_user_hours_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_bottom_modal_sheet.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/circle_button.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/custom_tab_bar.dart';
import 'package:gdsc_app/ui/widgets/custom_tab_bar.dart';
import 'package:stacked/stacked.dart';

class ProfileUserHoursView extends StatefulWidget {
  const ProfileUserHoursView({Key? key}) : super(key: key);

  @override
  State<ProfileUserHoursView> createState() => _ProfileUserHoursViewState();
}

class _ProfileUserHoursViewState extends State<ProfileUserHoursView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileUserHoursViewModel>.reactive(
        viewModelBuilder: () => ProfileUserHoursViewModel(context),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: 'طلبات تسجيل الساعات',
            ),
            body: SafeArea(
              child: DefaultTabController(
                length: 2,
                key: viewmodel.key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (viewmodel.isUser)
                      CustomTabBar(
                        tabs: const [
                          Tab(
                            text: 'مقبولة',
                          ),
                          Tab(
                            text: 'قيد الأنتظار',
                          ),
                        ],
                        widget: CircleButton(onPressed: () {
                          CustomModalBottomSheet(
                              context,
                              ProfileRequestHoursView(
                                onSubmit: (val) => setState(
                                    () => viewmodel.pendingUserHours.add(val)),
                              ));
                        }),
                      ),
                    if (viewmodel.isUser)
                      Expanded(
                          child: TabBarView(
                        children: [
                          ListView(
                              children: viewmodel.approvedUserHours
                                  .map((e) => ProfileVolunteerHoursCardBig(
                                        volunteerHours: e,
                                        isOwner: true,
                                      ))
                                  .toList()),
                          BusyOverlay(
                            isBusy: viewmodel.isBusy,
                            child: ListView(
                                children: viewmodel.pendingUserHours
                                    .map((e) => ProfileVolunteerHoursCardBig(
                                          volunteerHours: e,
                                          isOwner: true,
                                          onPressed: () =>
                                              viewmodel.removeHourRequest(e),
                                        ))
                                    .toList()),
                          ),
                        ],
                      ))
                    else
                      Expanded(
                        child: ListView(
                            children: viewmodel.approvedUserHours
                                .map((e) => ProfileVolunteerHoursCardBig(
                                      volunteerHours: e,
                                    ))
                                .toList()),
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
