import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/hours_approval/components/active_request_card.dart';

import '../../core/models/hour_request.dart';

class UpcomingHoursRequestView extends StatelessWidget {
  const UpcomingHoursRequestView(
      {super.key,
      required this.upcomingRequests,
      required this.updateHourRequest});
  final List<HourRequest> upcomingRequests;
  final void Function(HourRequest request, bool status) updateHourRequest;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: upcomingRequests.length,
            itemBuilder: (context, index) => ActiveRequestCard(
                  request: upcomingRequests[index],
                  onUpdate: updateHourRequest,
                )));
  }
}
