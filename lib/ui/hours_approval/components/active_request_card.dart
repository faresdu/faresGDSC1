import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/hour_request.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';

import '../../../core/utils/constants.dart';
import '../../widgets/action_button.dart';

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
        color: Constants.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: HelperFunctions.avatarImageProvider(
                      imageUrl: request.userAvatar ?? ''),
                  fit: BoxFit.fill),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        request.userName,
                        style: Constants.smallText.copyWith(
                          color: Constants.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(request.createdAt ?? "السبت ، 2023-20-6",
                            style: Constants.superSmallText.copyWith(
                              color: Constants.grey.withOpacity(0.7),
                              fontWeight: FontWeight.w700,
                            )),
                        if (request.approved != null)
                          SizedBox(
                            height: 20,
                            child: PopupMenuButton(
                                icon: const Icon(Icons.more_horiz),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                                onSelected: (value) async {
                                  if (value == 'reject') {
                                    bool? confirmed =
                                        await HelperFunctions.warningDialog(
                                            context,
                                            title: 'رفض الطلب',
                                            content:
                                                'هل انت متاكد من رفض الطلب؟',
                                            confirmButtonText: 'تاكيد');
                                    if (confirmed != null &&
                                        confirmed == true &&
                                        onUpdate != null) {
                                      onUpdate!(request, false);
                                    }
                                  } else if (value == 'approve') {
                                    bool? confirmed =
                                        await HelperFunctions.warningDialog(
                                      context,
                                      title: 'قبول الطلب',
                                      content: 'هل انت متاكد من قبول الطلب؟',
                                      confirmButtonText: 'تاكيد',
                                    );
                                    if (confirmed != null &&
                                        confirmed == true &&
                                        onUpdate != null) {
                                      onUpdate!(request, true);
                                    }
                                  }
                                },
                                itemBuilder: (context) => [
                                      request.approved!
                                          ? PopupMenuItem(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              value: 'reject',
                                              child: Text(
                                                'رفض الطلب',
                                                textAlign: TextAlign.center,
                                                style: Constants.verySmallText
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Constants.red),
                                              ),
                                            )
                                          : PopupMenuItem(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              value: 'approve',
                                              child: Text(
                                                'قبول الطلب',
                                                textAlign: TextAlign.center,
                                                style: Constants.verySmallText
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Constants.green),
                                              ),
                                            )
                                    ]),
                          )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),

                ///requester hours
                Row(
                  children: [
                    Row(children: [
                      const Icon(
                        Icons.access_time_filled,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        getHoursString(),
                        style: Constants.verySmallText.copyWith(
                          color: Constants.grey,
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
                      const Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "اسبوع ${request.semesterWeek}",
                        style: Constants.verySmallText.copyWith(
                          color: Constants.grey,
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
                    const Icon(
                      Icons.description,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.58,
                      child: Text(
                        request.reasoning,
                        style: Constants.verySmallText.copyWith(
                          color: Constants.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                request.approved == null
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
                                    ? Constants.lightGreen.withOpacity(0.35)
                                    : Constants.red.withOpacity(0.35),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 1, horizontal: 8),
                              child: Text(
                                request.approved! ? "مقبول" : "مرفوض",
                                textAlign: TextAlign.center,
                                style: Constants.smallText.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: request.approved!
                                        ? Constants.green
                                        : Constants.red),
                              ),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          )
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
