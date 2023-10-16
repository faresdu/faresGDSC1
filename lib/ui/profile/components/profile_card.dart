import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import '../../../core/models/member.dart';
import '../../../core/utils/constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.member,
    this.edit,
  });
  final Function()? edit;
  final Member member;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Constants.white,
        boxShadow: Constants.shadow4,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(63), bottomRight: Radius.circular(63)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              if (edit != null)
                Container(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: edit,
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                ),
              Center(
                child: ClipOval(
                    child: HelperFunctions.profileImage(
                        imageUrl: member.photo ?? '', height: 80, width: 80)),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            member.name,
            style: Constants.veryLargeText
                .copyWith(fontWeight: FontWeight.bold, height: 1),
          ),
          if (member.isLeaderOrCoLeader() || member.isConsultant())
            Text(
              "${member.getRole()} ${member.committee.name}",
              style: Constants.smallText
                  .copyWith(color: Constants.grey, fontWeight: FontWeight.bold),
            )
          else
            Text(
              member.committee.name,
              style: Constants.smallText
                  .copyWith(color: Constants.grey, fontWeight: FontWeight.bold),
            ),

          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildProfileInfoBox(
                  number: member.events.length,
                  bottomText: 'المشاركات',
                  icon: const Icon(
                    Icons.event_note_rounded,
                    color: Constants.green,
                    size: 20,
                  )),
              buildProfileInfoBox(
                  number: member.posts.length,
                  bottomText: 'المنشورات',
                  trailingDivider: true,
                  leadingDivider: true,
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 4, bottom: 2),
                    child: SvgPicture.asset(
                      'assets/icons/profile/timeline.svg',
                      color: Constants.red,
                      height: 16,
                      width: 16,
                    ),
                  )),
              buildProfileInfoBox(
                  number: member.hours,
                  bottomText: 'الساعات',
                  icon: const Icon(
                    Icons.access_time,
                    color: Constants.primaryLightBlue,
                    size: 20,
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          )
          // Container(
          //   margin: const EdgeInsets.fromLTRB(0, 25, 0, 5),
          //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12),
          //     border: Border.all(color: Constants.primaryLightBlue, width: 5),
          //   ),
          //   child: member.isLeaderOrCoLeader()
          //       ? Text(
          //           "${member.getRole()} ${member.committee.name}",
          //           style: Constants.largeText.copyWith(
          //               color: Constants.primaryLightBlue,
          //               fontWeight: FontWeight.bold),
          //         )
          //       : Text(
          //           member.committee.name,
          //           style: Constants.largeText.copyWith(
          //               color: Constants.primaryLightBlue,
          //               fontWeight: FontWeight.bold),
          //         ),
          // )
        ],
      ),
    );
  }

  Widget buildProfileInfoBox({
    required int number,
    required String bottomText,
    bool trailingDivider = false,
    bool leadingDivider = false,
    Widget? icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (trailingDivider)
          const SizedBox(
            height: 16,
            child: VerticalDivider(
              color: Constants.lightGrey,
              thickness: 1.3,
            ),
          ),
        Text(bottomText,
            style: Constants.extraSmallText.copyWith(
              height: 1,
              fontWeight: FontWeight.w700,
              color: Constants.lightGrey,
            )),
        const SizedBox(
          width: 5,
        ),
        Text(
          "$number",
          style: Constants.verySmallText.copyWith(
            height: 1,
            fontWeight: FontWeight.w900,
          ),
        ),
        if (icon != null) icon,
        if (leadingDivider)
          const SizedBox(
            height: 16,
            child: VerticalDivider(
              color: Constants.lightGrey,
              thickness: 1.3,
            ),
          ),
      ],
    );
  }
}
