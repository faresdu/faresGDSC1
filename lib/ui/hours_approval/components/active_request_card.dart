import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/hour_request.dart';
import '../../../core/utils/constants.dart';
import '../../widgets/action_button.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';

class ActiveRequestCard extends StatelessWidget {
  final Function(HourRequest request, bool status)? onUpdate;
  final HourRequest request;
  const ActiveRequestCard({this.onUpdate, required this.request, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 183,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(right: 20),
            child: Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white70,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.035,
                  right: MediaQuery.of(context).size.width * 0.15,
                  top: 10,
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          request.reasoning,
                          style: const TextStyle(
                            color: Constants.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(),
                        Text(request.createdAt ?? "السبت ، 2023-20-6",
                            style: Constants.extraSmallText.copyWith(
                              color: Constants.grey.withOpacity(0.7),
                              fontWeight: FontWeight.w700,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    /// requester name
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          request.userName,
                          style: TextStyle(
                            color: Constants.grey.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),

                    ///requester hours
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_filled,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          getHoursString(),
                          style: TextStyle(
                            color: Constants.grey.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Spacer(),

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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        ///Avatar
        Positioned(
            child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: HelperFunctions.avatarImageProvider(
                    imageUrl: request.userAvatar ?? ''),
                fit: BoxFit.fill),
            shape: BoxShape.circle,
          ),
        ))
      ],
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
