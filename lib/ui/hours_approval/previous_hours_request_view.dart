import 'package:flutter/material.dart';

import '../../core/models/hour_request.dart';
import 'components/expandable_request_card.dart';

class PreviousHoursRequestView extends StatelessWidget {
  const PreviousHoursRequestView(
      {Key? key,
      required this.previousRequests,
      required this.onApproveOrReject})
      : super(key: key);
  final List<HourRequest> previousRequests;
  final void Function(HourRequest request, bool status) onApproveOrReject;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: previousRequests.length,
          itemBuilder: (context, index) => ExpandableActiveRequestCard(
                request: previousRequests[index],
                onUpdate: onApproveOrReject,
              )),
    );
  }
}
