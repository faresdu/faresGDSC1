import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'components/active_request_card.dart';
import 'hours_request_viewmodel.dart';

class PreviousHoursRequestView extends StatelessWidget {
  const PreviousHoursRequestView({Key? key}) : super(key: key);

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
                itemCount: viewmodel.previousRequests.length,
                itemBuilder: (context, index) => ActiveRequestCard(
                    request: viewmodel.previousRequests[index])),
          );
        });
  }
}
