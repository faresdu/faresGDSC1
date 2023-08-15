import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/leaderboard_member.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/leaderboard/leaderboard_viewmodel.dart';
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
          appBar: AppBar(
            centerTitle: true,
            title: const Text('قائمة المتصدرين'),
            automaticallyImplyLeading: false,
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
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
                      member: viewmodel.members[1],
                      width: 100,
                      height: 100,
                      smWidth: 100,
                      smHeight: 40,
                      bottomRight: 20,
                      smTopRight: 20,
                      offsetY: 4,
                      fontSize: 14,
                      color: Constants.greenTOP,
                      top: 132,
                      right: 35,
                      numSize: 30,
                      profileTop: 64,
                      profileRight: 21,
                      numColor: Constants.green),
                  top123LeaderBoard(
                      position: 1,
                      member: viewmodel.members[0],
                      width: 110,
                      height: 130,
                      smWidth: 110,
                      smHeight: 50,
                      smTopLeft: 20,
                      smTopRight: 20,
                      offsetY: 4,
                      fontSize: 14,
                      numFontSize: 20,
                      color: Constants.yellowTOP.withOpacity(0.43),
                      top: 98,
                      right: 36,
                      numSize: 40,
                      profileRaduis: 40,
                      profileRight: 17,
                      profileTop: 10,
                      numColor: Constants.yellowNumber),
                  top123LeaderBoard(
                      position: 2,
                      member: viewmodel.members[2],
                      width: 100,
                      height: 100,
                      smWidth: 100,
                      smHeight: 40,
                      bottomLeft: 20,
                      smTopLeft: 20,
                      offsetY: 4,
                      fontSize: 14,
                      color: Constants.redTOP,
                      top: 132,
                      right: 35,
                      numSize: 30,
                      profileTop: 64,
                      profileRight: 21,
                      numColor: Constants.redNumber),
                ],
              ),
              SizedBox(height: 60),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: viewmodel.members
                    .map((e) => Row(
                          children: [Text(e.name), Text(e.hours.toString())],
                        ))
                    .toList(),
              )
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
      double? offsetY = 0,
      double fontSize = 10,
      double numFontSize = 15,
      double profileTop = 0,
      double profileRight = 0,
      double profileRaduis = 30,
      String image = "",
      required Color numColor,
      required double numSize,
      required double right,
      required double top,
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
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("${member.hours}",
                              style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: FontWeight.bold))
                        ]),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.15), // Shadow color
                            offset: Offset(offsetX!,
                                offsetY!), // Offset in the form of (dx, dy)
                            blurRadius: 4, // Blur radius
                            spreadRadius: 0, // Spread radius
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
          child: CircleAvatar(
            radius: profileRaduis,
            backgroundImage: NetworkImage(member.),
          ),
        ),
      ],
    );
  }

  Widget bottomLeaderBoard(int position, LeaderboardMember member) {
    return ListTile(
      title: Text('${member.name} - ${member.hours} hours'),
      subtitle: Text('Position $position'),
    );
  }
}
