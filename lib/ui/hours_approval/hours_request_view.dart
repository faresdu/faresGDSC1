import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/hours_approval/previous_hours_request_view.dart';
import 'package:gdsc_app/ui/hours_approval/upcoming_hours_request_view.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/custom_tab_bar.dart';
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
    return const Column(
      children: [
        CustomTapBar(tabs: [
          Tab(
            text: 'القادمة',
          ),
          Tab(
            text: 'السابقة',
          ),
        ]),
        Expanded(
          child: TabBarView(children: [
            UpcomingHoursRequestView(),
            PreviousHoursRequestView()
          ]),
        ),
      ],
    );
  }
}
