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
        onViewModelReady: ((viewModel) =>
            viewModel.getUpcomingHourRequests(context)),
        builder: (context, viewmodel, _) {
          return Container(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: viewmodel.upcomingRequests.length,
                  itemBuilder: (context, index) => ActiveRequestCard(
                        request: viewmodel.upcomingRequests[index],
                        onUpdate: viewmodel.updateHourRequest,
                      )));
        });
  }
}
