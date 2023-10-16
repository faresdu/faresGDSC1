import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/leaderboard_member.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';

class LeaderboardItem extends StatelessWidget {
  const LeaderboardItem(
      {Key? key,
      required this.member,
      required this.index,
      this.navigateToProfile})
      : super(key: key);
  final LeaderboardMember member;
  final int index;
  final void Function(String id)? navigateToProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(index == 0 ? 20 : 0),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: (index + 4) < 10 ? 35 : 50,
                    height: 35,
                    padding: const EdgeInsets.only(right: 15),
                    margin: const EdgeInsets.only(left: 4),
                    child: Text(
                      "${index + 4}",
                      style:
                          const TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                  ),
                  ClipOval(
                    clipBehavior: Clip.hardEdge,
                    child: HelperFunctions.profileImage(
                        imageUrl: member.profilePicture,
                        gender: member.gender ?? "",
                        width: 55,
                        height: 55),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (navigateToProfile != null) {
                        navigateToProfile!(member.id);
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text("${member.committee?.name}",
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Constants.grey))
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(index == 0 ? 20 : 0),
                  ),
                ),
                child: Center(
                    child: Text(
                  "${member.hours}",
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )),
              ),
            ],
          ),
          const Divider(
            color: Constants.greyDivider,
            height: 01,
            thickness: 1.5,
          )
        ],
      ),
    );
  }
}
