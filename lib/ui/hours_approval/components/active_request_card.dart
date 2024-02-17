import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/hour_request.dart';
import 'package:gdsc_app/ui/hours_approval/components/request_body.dart';
import 'package:gdsc_app/ui/hours_approval/components/request_footer.dart';
import 'package:gdsc_app/ui/hours_approval/components/request_header.dart';

import '../../../core/utils/constants.dart';

class ActiveRequestCard extends StatelessWidget {
  final Function(HourRequest request, bool status)? onUpdate;
  final HourRequest request;

  const ActiveRequestCard({this.onUpdate, required this.request, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          // boxShadow: Constants.shadow,
          borderRadius: BorderRadius.circular(20),
          color: Constants.cardBackground(context),
        ),
        child: Column(
          children: [
            RequestHeader(request: request, onUpdate: onUpdate),
            RequestBody(request: request),
            RequestFooter(
                request: request, onUpdate: onUpdate, padding: EdgeInsets.zero),
          ],
        ));
  }
}
