import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/hour_request.dart';
import 'package:gdsc_app/ui/hours_approval/components/request_body.dart';
import 'package:gdsc_app/ui/hours_approval/components/request_footer.dart';
import 'package:gdsc_app/ui/hours_approval/components/request_header.dart';
import 'package:gdsc_app/ui/widgets/expandable_card.dart';

import '../../../core/utils/constants.dart';

class ExpandableActiveRequestCard extends StatelessWidget {
  final Function(HourRequest request, bool status)? onUpdate;
  final HourRequest request;

  const ExpandableActiveRequestCard(
      {this.onUpdate, required this.request, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableCard(
        color: Constants.cardBackground(context),
        title: RequestHeader(request: request, onUpdate: onUpdate),
        expandedSection: RequestBody(request: request),
        footer: RequestFooter(request: request, onUpdate: onUpdate));
  }
}
