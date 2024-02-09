import 'package:flutter/material.dart';

import '../../core/models/hour_request.dart';
import 'components/active_request_card.dart';

class PreviousHoursRequestView extends StatelessWidget {
  const PreviousHoursRequestView({super.key, required this.previousRequests});
  final List<HourRequest> previousRequests;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: previousRequests.length,
          itemBuilder: (context, index) =>
              ActiveRequestCard(request: previousRequests[index])),
    );
  }
}
