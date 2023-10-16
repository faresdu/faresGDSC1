import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';

class CommitteeLeaderCard extends StatelessWidget {
  final Member member;
  final bool? isCoLeader;
  final void Function(String id)? onTap;

  const CommitteeLeaderCard(
      {required this.member, this.isCoLeader, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 25,
            left: 0,
            right: 0,
            child: ElevatedButton(
              onPressed: () => onTap!(member.id),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                elevation: 3,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: Row(
                children: [
                  Container(
                    height: 86,
                    width: 50,
                    decoration: const BoxDecoration(
                        color: Constants.lightBlue,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        )),
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: -3,
                        child: Text(
                          (getRoleText()),
                          style: (isCoLeader == null
                                  ? Constants.mediumText
                                  : Constants.veryLargeText)
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    member.name,
                    style: Constants.mediumText.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 86,
                    width: 80,
                    decoration: const BoxDecoration(
                        color: Constants.primaryLightBlue,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        )),
                    child: const Center(
                        child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 30,
                    )),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 60,
            top: 10,
            child: ClipOval(
              child: HelperFunctions.profileImage(
                  imageUrl: member.photo ?? '', height: 45, width: 45),
            ),
          ),
        ],
      ),
    );
  }

  getRoleText() {
    if (isCoLeader != null) {
      return isCoLeader! ? 'النائب' : 'القائد';
    }
    return "مستشار";
  }
}
