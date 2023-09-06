import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/hours_approval/components/active_request_card.dart';
import 'package:gdsc_app/ui/hours_approval/hours_request_viewmodel.dart';
import 'package:stacked/stacked.dart';

class UpcomingHoursRequestView extends StatelessWidget {
  const UpcomingHoursRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HoursRequestViewModel>.reactive(
        viewModelBuilder: () => HoursRequestViewModel(),
        onViewModelReady: ((viewModel) => viewModel.getUpcomingHourRequests()),
        builder: (context, viewmodel, _) {
          return Container(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                    children: viewmodel.upcomingRequests
                        .map((e) => ActiveRequestCard(
                              request: e,
                              onUpdate: viewmodel.updateHourRequest,
                            ))
                        .toList()),
              ));
        });
  }
}
