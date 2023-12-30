import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/hours_approval/previous_hours_request_view.dart';
import 'package:gdsc_app/ui/hours_approval/upcoming_hours_request_view.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:stacked/stacked.dart';

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
          return DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: CustomAppBar(
                  title: 'الطلبات',
                  preferredSize: const Size.fromHeight(110),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(60),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        child: TabBar(
                          unselectedLabelStyle: Constants.mediumText.copyWith(
                              color: Colors.black, fontWeight: FontWeight.w700),
                          labelStyle: Constants.mediumText.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w700),
                          unselectedLabelColor: Colors.black,
                          indicator: BoxDecoration(
                              color: Constants.blueButton,
                              borderRadius: BorderRadius.circular(25)),
                          tabs: const <Widget>[
                            Tab(
                              text: 'القادمة',
                            ),
                            Tab(
                              text: 'السابقة',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
        viewModelBuilder: () => HoursRequestViewModel(),
        builder: (context, viewmodel, _) {
          return SafeArea(
            child: BusyOverlay(
              isBusy: viewmodel.isBusy,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(10, 16, 10, 0),
                          decoration: BoxDecoration(
                            // color: Constants.black,
                            border: Border.all(
                              color: Constants.black,
                              width: 2,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () =>
                                viewmodel.openFilterDialog(context),
                            icon: Icon(Icons.filter_alt_outlined, size: 25),
                            constraints: BoxConstraints(),
                            padding: EdgeInsets.all(8),
                          )),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      UpcomingHoursRequestView(
                        upcomingRequests: viewmodel.upcomingRequests,
                        updateHourRequest: viewmodel.updateHourRequest,
                      ),
                      PreviousHoursRequestView(
                        previousRequests: viewmodel.previousRequests,
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
