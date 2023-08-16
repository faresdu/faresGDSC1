import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/leaderboard_member.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import 'package:gdsc_app/ui/leaderboard/leaderboard_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/custom_buttom.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/member.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LeaderboardViewModel>.reactive(
      viewModelBuilder: () => LeaderboardViewModel(),
      onViewModelReady: (model) => model.getLeaderboard(),
      builder: (context, viewmodel, _) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "قائمة المتصدرين",
            leading: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                "./assets/images/BarLogo.png",
              ),
            ),
            leadingWidth: 100,
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 25, right: 15),
                    child: CustomButton(
                      onPressed: () {
                        viewmodel.navigateToHierarchy();
                      },
                      text: 'الهيكلة',
                      color: Constants.primaryLightBlue,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  top123LeaderBoard(
                      position: 3,
                      member: viewmodel.members[2],
                      width: 110,
                      height: 100,
                      bottomRight: 20,
                      smWidth: 110,
                      smHeight: 40,
                      smTopRight: 20,
                      color: Constants.greenTOP,
                      numColor: Constants.green),
                  top123LeaderBoard(
                      position: 1,
                      member: viewmodel.members[0],
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
                  top123LeaderBoard(
                      position: 2,
                      member: viewmodel.members[1],
                      width: 110,
                      height: 100,
                      bottomLeft: 20,
                      smWidth: 110,
                      smHeight: 40,
                      smTopLeft: 20,
                      color: Constants.redTOP,
                      numColor: Constants.redNumber),
                ],
              ),
              SizedBox(height: 50),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    boxShadow: Constants.shadow4,
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: viewmodel.members.length - 3,
                    itemBuilder: (context, index) {
                      return bottomLeaderBoard(
                          index + 4, viewmodel.members[index + 3], index);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget top123LeaderBoard(
      {required int position,
      required LeaderboardMember member,
      required double width,
      required double height,
      required double smWidth,
      required double smHeight,
      double? topLeft = 0,
      double? topRight = 0,
      double? bottomRight = 0,
      double? bottomLeft = 0,
      double? smTopLeft = 0,
      double? smTopRight = 0,
      double? smBottomRight = 0,
      double? smBottomLeft = 0,
      double? offsetX = 0,
      double? offsetY = 4,
      double fontSize = 15,
      double numFontSize = 15,
      double profileTop = 42,
      double profileRight = 15,
      double profileRaduis = 80,
      required Color numColor,
      double numSize = 37,
      double top = 130,
      double right = 36,
      Color? color}) {
    return Stack(
      children: [
        Container(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Container(
                    width: smWidth,
                    height: smHeight,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(smTopLeft!),
                            topRight: Radius.circular(smTopRight!),
                            bottomLeft: Radius.circular(smBottomLeft!),
                            bottomRight: Radius.circular(smBottomRight!))),
                  ),
                  Container(
                    width: width,
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          member.name,
                          style: TextStyle(
                              fontSize: fontSize, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${member.hours}",
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "ساعة",
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold,
                                  color: Constants.black3),
                            ),
                          ],
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            offset: Offset(offsetX!, offsetY!),
                            blurRadius: 4,
                            spreadRadius: 0,
                          ),
                        ],
                        color: Constants.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(topLeft!),
                            topRight: Radius.circular(topRight!),
                            bottomLeft: Radius.circular(bottomLeft!),
                            bottomRight: Radius.circular(bottomRight!))),
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          child: Container(
            width: numSize,
            height: numSize,
            decoration: BoxDecoration(
              color: numColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "$position",
                style: TextStyle(
                  fontSize: numFontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          top: top,
          right: right,
        ),
        Positioned(
          top: profileTop,
          right: profileRight,
          child: ClipOval(
            child: HelperFunctions.profileImage(
              imageUrl: member.profilePicture,
              width: profileRaduis,
              height: profileRaduis,
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomLeaderBoard(int position, LeaderboardMember member, index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 35,
                    padding: const EdgeInsets.only(right: 15),
                    margin: const EdgeInsets.only(left: 8),
                    child: Text(
                      "${index + 4}#",
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                  ),
                  ClipOval(
                    clipBehavior: Clip.hardEdge,
                    child: HelperFunctions.profileImage(
                        imageUrl: member.profilePicture, width: 55, height: 55),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${member.name}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text("${member.committee?.name}",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Constants.grey))
                    ],
                  )
                ],
              ),
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
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              )),
            ),
          ],
        ),
        Divider(
          color: Constants.greyDivider,
          height: 01,
          thickness: 1.5,
        )
      ],
    );
  }
}
