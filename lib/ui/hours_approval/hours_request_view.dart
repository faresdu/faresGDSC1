import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/hours_approval/previous_hours_request_view.dart';
import 'package:gdsc_app/ui/hours_approval/upcoming_hours_request_view.dart';
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
                appBar: AppBar(
                  backgroundColor: Constants.background,
                  centerTitle: true,
                  title: const Text(
                    'الطلبات',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                    ),
                  ),
                  elevation: 0,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(60),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25)),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TabBar(
                        unselectedLabelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                        labelStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
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
                body: HoursRequestBody(),
              ));
        });
  }
}

class HoursRequestBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const TabBarView(
        children: [UpcomingHoursRequestView(), PreviousHoursRequestView()]);
  }
}
