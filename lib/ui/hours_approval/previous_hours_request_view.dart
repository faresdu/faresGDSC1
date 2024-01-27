import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/hour_request.dart';
import 'components/active_request_card.dart';
import 'hours_request_viewmodel.dart';

class PreviousHoursRequestView extends StatelessWidget {
  const PreviousHoursRequestView({Key? key, required this.previousRequests})
      : super(key: key);
  final List<HourRequest> previousRequests;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HoursRequestViewModel>.reactive(
        viewModelBuilder: () => HoursRequestViewModel(),
        onViewModelReady: ((viewModel) =>
            viewModel.getPreviousHourRequests(context)),
        builder: (context, viewmodel, _) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: previousRequests.length,
                itemBuilder: (context, index) =>
                    ActiveRequestCard(request: previousRequests[index])),
          );
        });
  }
}
