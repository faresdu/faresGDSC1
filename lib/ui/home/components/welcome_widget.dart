import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';

import '../../../core/models/member.dart';
import '../../../core/utils/constants.dart';
import 'calender_week.dart';

class Welcome extends StatelessWidget {
  final int? currentWeek;
  final Member user;

  const Welcome({
    required this.user,
    this.currentWeek,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String getName() {
      if (user.name.split(" ").length > 2 && user.name.length > 18) {
        return " ${user.name.split(" ").first} ${user.name.split(" ").last}";
      }
      return " ${user.name}";
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: Constants.memberIconShadow),
                child: ClipOval(
                    child: HelperFunctions.profileImage(
                        imageUrl: user.photo ?? '',
                        gender: user.gender ?? "",
                        height: 65,
                        width: 65))),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.53,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("أهلا",
                          style: Constants.largeText
                              .copyWith(fontWeight: FontWeight.w400)),
                      Text(
                        getName(),
                        style: Constants.largeText
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${user.isLeaderOrCoLeader() | user.isConsultant() ? user.getRole() : ''} ${user.committee.name}"
                      .trim(),
                  style: Constants.smallText
                      .copyWith(height: 1.2, color: Constants.grey),
                ),
              ],
            ),
          ],
        ),
        if (currentWeek != null) CalenderWeek(currentWeek: currentWeek)
      ],
    );
  }
}
