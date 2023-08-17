import 'package:flutter/cupertino.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/leaderboard/components/top3_item.dart';
import '../../../core/models/leaderboard_member.dart';

class Top3 extends StatelessWidget {
  const Top3({required this.members, this.navigateToProfile, super.key});
  final List<LeaderboardMember> members;
  final void Function(String id)? navigateToProfile;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Top3Item(
            position: 3,
            member: members[2],
            navigateToProfile: navigateToProfile,
            width: 110,
            height: 100,
            bottomRight: 20,
            smWidth: 110,
            smHeight: 40,
            smTopRight: 20,
            color: Constants.greenTOP,
            numColor: Constants.green),
        Top3Item(
            position: 1,
            member: members[0],
            navigateToProfile: navigateToProfile,
            width: 120,
            height: 130,
            smWidth: 120,
            smHeight: 50,
            smTopLeft: 20,
            smTopRight: 20,
            fontSize: 14,
            numFontSize: 20,
            top: 98,
            right: 39,
            numSize: 42,
            profileRaduis: 90,
            profileTop: 0,
            profileRight: 15,
            color: Constants.yellowTOP.withOpacity(0.43),
            numColor: Constants.yellowNumber),
        Top3Item(
            position: 2,
            member: members[1],
            navigateToProfile: navigateToProfile,
            width: 110,
            height: 100,
            bottomLeft: 20,
            smWidth: 110,
            smHeight: 40,
            smTopLeft: 20,
            color: Constants.redTOP,
            numColor: Constants.redNumber),
      ],
    );
  }
}
