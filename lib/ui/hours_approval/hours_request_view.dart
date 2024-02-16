import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/hours_approval/previous_hours_request_view.dart';
import 'package:gdsc_app/ui/hours_approval/upcoming_hours_request_view.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/committee.dart';
import '../widgets/custom_tab_bar.dart';
import 'components/filter_button.dart';
import 'components/filter_options.dart';
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
          final currentCommittee = (ModalRoute.of(context)!.settings.arguments
              as List<Committee>)[0];
          return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: CustomAppBar(
                  title: currentCommittee.name,
                ),
                backgroundColor: Constants.grayBackGround,
                body: const HoursRequestBody(),
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
                    tabBarWidthMultiplier: 0.775,
                    widget: FilterButton(
                      onPressed: () => viewmodel.openFilterDialog(context),
                      selectedSemesterWeeksList:
                          viewmodel.selectedSemesterWeeksList,
                    ),
                    tabs: const [
                      Tab(
                        text: 'الطلبات القادمة',
                      ),
                      Tab(
                        text: 'الطلبات السابقة',
                      ),
                    ],
                  ),
                  FilterOptions(
                    selectedSemesterWeeksList:
                        viewmodel.selectedSemesterWeeksList,
                    selectedWeeksText: viewmodel.selectedWeeksText,
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      UpcomingHoursRequestView(
                        upcomingRequests: viewmodel.getUpcomingRequests,
                        updateHourRequest: viewmodel.updateHourRequest,
                      ),
                      PreviousHoursRequestView(
                        previousRequests: viewmodel.getPreviousRequests,
                        onApproveOrReject: viewmodel.onApproveOrReject,
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
