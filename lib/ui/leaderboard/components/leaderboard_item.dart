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
    double getWidth() {
      if ((index + 4) < 10) {
        return MediaQuery.of(context).size.width * 0.46;
      }
      if ((index + 4) < 100) {
        return MediaQuery.of(context).size.width * 0.43;
      }
      return MediaQuery.of(context).size.width * 0.4;
    }

    return Container(
      decoration: BoxDecoration(
        color: Constants.cardBackground(context),
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
                    width: (index + 4) < 10
                        ? 32
                        : (index + 4) < 100
                            ? 40
                            : 51,
                    height: 35,
                    padding: const EdgeInsets.only(right: 15),
                    margin: const EdgeInsets.only(left: 4),
                    child: Text(
                      "${index + 4}",
                      style: Constants.largeText
                          .copyWith(color: Constants.black3(context)),
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
                    width: 10,
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
                        SizedBox(
                          width: getWidth(),
                          child: Text(
                            member.name,
                            overflow: TextOverflow.ellipsis,
                            style: Constants.verySmallText.copyWith(
                                color: Constants.black(context),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text("${member.committee?.name}",
                            style: Constants.extraSmallText.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Constants.black3(context)))
                      ],
                    ),
                  )
                ],
              ),
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: Constants.primary(context),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(index == 0 ? 20 : 0),
                  ),
                ),
                child: Center(
                    child: Text(
                  "${member.hours}",
                  style: Constants.superLargeText.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
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
