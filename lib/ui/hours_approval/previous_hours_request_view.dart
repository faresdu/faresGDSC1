import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:stacked/stacked.dart';

import 'components/active_request_card.dart';
import 'hours_request_viewmodel.dart';

class PreviousHoursRequestView extends StatelessWidget {
  const PreviousHoursRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HoursRequestViewModel>.nonReactive(
        viewModelBuilder: () => locator<HoursRequestViewModel>(),
        onViewModelReady: ((viewModel) => viewModel.getPreviousHourRequests()),
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
