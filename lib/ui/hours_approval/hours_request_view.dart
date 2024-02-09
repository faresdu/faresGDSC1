import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/hours_approval/previous_hours_request_view.dart';
import 'package:gdsc_app/ui/hours_approval/upcoming_hours_request_view.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:stacked/stacked.dart';

import '../widgets/custom_tab_bar.dart';
import 'hours_request_viewmodel.dart';

class HoursRequestView extends StatefulWidget {
  const HoursRequestView({Key? key}) : super(key: key);

  @override
  State<HoursRequestView> createState() => _HoursRequestViewState();
}

class _HoursRequestViewState extends State<HoursRequestView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HoursRequestViewModel>.reactive(
        viewModelBuilder: () => HoursRequestViewModel(),
        builder: (context, viewmodel, _) {
          return const DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: CustomAppBar(
                  title: 'الطلبات',
                ),
                backgroundColor: Constants.grayBackGround,
                body: HoursRequestBody(),
              ));
        });
  }
}

class HoursRequestBody extends StatelessWidget {
  const HoursRequestBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HoursRequestViewModel>.reactive(
        onViewModelReady: (viewModel) => viewModel.init(context),
        viewModelBuilder: () => HoursRequestViewModel.init(context),
        builder: (context, viewmodel, _) {
          return SafeArea(
            child: BusyOverlay(
              isBusy: viewmodel.isBusy,
              child: Column(
                children: [
                  CustomTabBar(
                    widget: Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                          color: viewmodel.selectedSemesterWeeksList.isNotEmpty
                              ? Constants.lightBlue.withOpacity(0.4)
                              : null,
                          border: viewmodel.selectedSemesterWeeksList.isNotEmpty
                              ? Border.all(
                                  color: Constants.primaryLightBlue,
                                  width: 2,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          onPressed: () => viewmodel.openFilterDialog(context),
                          icon: Icon(
                            Icons.filter_alt_outlined,
                            size: 25,
                            color:
                                viewmodel.selectedSemesterWeeksList.isNotEmpty
                                    ? Constants.blueButton
                                    : Constants.black,
                          ),
                          constraints: const BoxConstraints(),
                          padding: const EdgeInsets.all(8),
                        )),
                    tabBarWidthMultiplier: 0.775,
                    tabs: const [
                      Tab(
                        text: 'الطلبات القادمة',
                      ),
                      Tab(
                        text: 'الطلبات السابقة',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // container that shows the number of weeks selected
                      if (viewmodel.selectedSemesterWeeksList.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            color: Constants.lightBlue.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            viewmodel.selectedWeeksText,
                            style: Constants.smallText.copyWith(
                                color: Constants.blueButton,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      UpcomingHoursRequestView(
                        upcomingRequests: viewmodel.getUpcomingRequests,
                        updateHourRequest: viewmodel.updateHourRequest,
                      ),
                      PreviousHoursRequestView(
                        previousRequests: viewmodel.getPreviousRequests,
                      )
                    ]),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
