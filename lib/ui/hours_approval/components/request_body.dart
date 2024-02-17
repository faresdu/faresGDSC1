import 'package:flutter/material.dart';

import '../../../core/models/hour_request.dart';
import '../../../core/utils/constants.dart';

class RequestBody extends StatelessWidget {
  const RequestBody({
    super.key,
    required this.request,
  });

  final HourRequest request;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 28, 0),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),

          ///requester hours
          Row(
            children: [
              Row(children: [
                Icon(
                  Icons.access_time_filled,
                  color: Constants.black(context),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  getHoursString(),
                  style: Constants.verySmallText.copyWith(
                    color: Constants.black(context),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ])
            ],
          ),
          if (request.semesterWeek != null) ...[
            const SizedBox(
              height: 10,
            ),
            //Semester week
            Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Constants.black(context),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "اسبوع ${request.semesterWeek}",
                  style: Constants.verySmallText.copyWith(
                    color: Constants.black(context),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(
            height: 10,
          ),

          ///reasoning
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.description,
                color: Constants.black(context),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.58,
                child: Text(
                  request.reasoning,
                  style: Constants.verySmallText.copyWith(
                    color: Constants.black(context),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  String getHoursString() {
    if (request.hours == 1) {
      return 'طلب ساعة';
    } else if (request.hours == 2) {
      return 'طلب ساعتان';
    } else {
      return 'طلب ${request.hours} ساعات';
    }
  }
}
