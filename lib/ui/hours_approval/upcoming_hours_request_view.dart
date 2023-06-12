import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/hour_request.dart';
import 'package:gdsc_app/ui/hours_approval/components/active_request_card.dart';
import 'package:gdsc_app/ui/hours_approval/hours_request_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../core/utils/constants.dart';

class UpcomingHoursRequestView extends StatelessWidget {
  const UpcomingHoursRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HoursRequestViewModel>.reactive(
        viewModelBuilder: () => HoursRequestViewModel(),
        builder: (context, viewmodel, _) {
          return Container(
            padding: EdgeInsets.all(10),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return _reuseableWidget(context);
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 12,
                );
              },
            ),
          );
        });
  }

  Widget _reuseableWidget(context) {
    return ActiveRequestCard(
        onApprove: () {},
        onReject: () {},
        request: HourRequest(
            userId: '123',
            userName: "رزان الضفيان",
            id: '212',
            hours: 5,
            committeeId: '123123',
            reasoning: 'تعبئة شيت الساعات',
            createdAt: "السبت ، 2023-20-6"));
  }
}
