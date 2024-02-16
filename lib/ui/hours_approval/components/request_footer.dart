import 'package:flutter/material.dart';

import '../../../core/models/hour_request.dart';
import '../../../core/utils/constants.dart';
import '../../widgets/action_button.dart';

class RequestFooter extends StatelessWidget {
  const RequestFooter({
    super.key,
    required this.request,
    required this.onUpdate,
    this.padding,
  });

  final HourRequest request;
  final Function(HourRequest request, bool status)? onUpdate;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.fromLTRB(10, 16, 0, 6),
      child: request.approved == null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ActionButton(
                    onTap: () {
                      try {
                        onUpdate!(request, true);
                      } catch (e) {}
                    },
                    isApprove: true),
                const SizedBox(
                  width: 10,
                ),
                ActionButton(
                    onTap: () {
                      try {
                        onUpdate!(request, false);
                      } catch (e) {}
                    },
                    isApprove: false),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: request.approved!
                          ? Constants.positiveLight.withOpacity(0.35)
                          : Constants.negative.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                    child: Text(
                      request.approved! ? "مقبول" : "مرفوض",
                      textAlign: TextAlign.center,
                      style: Constants.smallText.copyWith(
                          fontWeight: FontWeight.bold,
                          color: request.approved!
                              ? Constants.positive
                              : Constants.negative),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
