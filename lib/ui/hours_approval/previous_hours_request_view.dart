import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/hour_request.dart';
import 'components/active_request_card.dart';
import 'hours_request_viewmodel.dart';

class PreviousHoursRequestView extends StatefulWidget {
  const PreviousHoursRequestView({Key? key}) : super(key: key);

  @override
  State<PreviousHoursRequestView> createState() =>
      _PreviousHoursRequestViewState();
}

class _PreviousHoursRequestViewState extends State<PreviousHoursRequestView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HoursRequestViewModel>.reactive(
        viewModelBuilder: () => HoursRequestViewModel(),
        onViewModelReady: ((viewModel) => viewModel.getPreviousHourRequests()),
        builder: (context, viewmodel, _) {
          return Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                    children: viewmodel.previousRequests
                        .map((e) => ActiveRequestCard(
                              request: e,
                            ))
                        .toList()),
              ));
        });
  }
}
