import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/profile/components/profile_volunteer_hours_card_big.dart';
import 'package:gdsc_app/ui/profile/profile_user_hours/profile_request_hours_view.dart';
import 'package:gdsc_app/ui/profile/profile_user_hours/profile_user_hours_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/bottom_sheet_post.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/circle_button.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:stacked/stacked.dart';

class ProfileUserHoursView extends StatelessWidget {
  const ProfileUserHoursView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileUserHoursViewModel>.reactive(
        viewModelBuilder: () => ProfileUserHoursViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: 'طلبات تسجيل الساعات',
            ),
            backgroundColor: Constants.background,
            body: SafeArea(
              child: DefaultTabController(
                length: 2,
                key: GlobalKey(debugLabel: 'profile_hours'),
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
                                  text: 'مقبوله',
                                ),
                                Tab(
                                  text: 'قيد الانتظار',
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          CircleButton(onPressed: () {
                            bottomSheetPost(context, ProfileRequestHoursView());
                          })
                        ],
                      ),
                    ),
                    Expanded(
                        child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                              children: viewmodel.approvedUserHours
                                  .map((e) => ProfileVolunteerHoursCardBig(
                                        volunteerHours: e,
                                        isOwner: true,
                                      ))
                                  .toList()),
                        ),
                        BusyOverlay(
                          isBusy: viewmodel.isBusy,
                          child: SingleChildScrollView(
                            child: Column(
                                children: viewmodel.pendingUserHours
                                    .map((e) => ProfileVolunteerHoursCardBig(
                                          volunteerHours: e,
                                          isOwner: true,
                                          onPressed: () {
                                            viewmodel.removeHourRequest(e);
                                          },
                                        ))
                                    .toList()),
                          ),
                        ),
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
