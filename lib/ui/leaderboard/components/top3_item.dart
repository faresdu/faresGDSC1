import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/leaderboard_member.dart';
import 'package:gdsc_app/core/utils/constants.dart';

import '../../../core/utils/helper_functions.dart';

class Top3Item extends StatelessWidget {
  const Top3Item(
      {Key? key,
      required this.member,
      required this.position,
      required this.width,
      required this.height,
      required this.smWidth,
      required this.smHeight,
      required this.numColor,
      this.navigateToProfile,
      this.topLeft = 0,
      this.topRight = 0,
      this.bottomRight = 0,
      this.bottomLeft = 0,
      this.smTopLeft = 0,
      this.smTopRight = 0,
      this.smBottomRight = 0,
      this.smBottomLeft = 0,
      this.offsetX = 0,
      this.offsetY = 4,
      this.fontSize = 15,
      this.numFontSize = 15,
      this.profileTop = 42,
      this.profileRight = 15,
      this.profileRaduis = 80,
      this.numSize = 37,
      this.top = 130,
      this.right = 36,
      this.color})
      : super(key: key);
  final LeaderboardMember member;
  final void Function(String id)? navigateToProfile;
  final int position;
  final double width;
  final double height;
  final double smWidth;
  final double smHeight;
  final double? topLeft;
  final double? topRight;
  final double? bottomRight;
  final double? bottomLeft;
  final double? smTopLeft;
  final double? smTopRight;
  final double? smBottomRight;
  final double? smBottomLeft;
  final double? offsetX;
  final double? offsetY;
  final double fontSize;
  final double numFontSize;
  final double profileTop;
  final double profileRight;
  final double profileRaduis;
  final Color numColor;
  final double numSize;
  final double top;
  final double right;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
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
                    child: InkWell(
                      onTap: () {
                        if (navigateToProfile != null) {
                          navigateToProfile!(member.id);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            member.name,
                            style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold),
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
                              const SizedBox(
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
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: top,
          right: right,
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
        ),
        Positioned(
          top: profileTop,
          right: profileRight,
          child: ClipOval(
            child: HelperFunctions.profileImage(
              imageUrl: member.profilePicture ?? '',
              width: profileRaduis,
              height: profileRaduis,
            ),
          ),
        ),
      ],
    );
  }
}
