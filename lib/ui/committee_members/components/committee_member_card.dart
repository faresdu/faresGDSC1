import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';

class CommitteeMemberCard extends StatelessWidget {
  final Member member;
  final void Function(String id)? onTap;

  const CommitteeMemberCard({required this.member, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(member.id),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: ClipOval(
                child: HelperFunctions.profileImage(
                    imageUrl: member.photo ?? '', height: 55, width: 55),
              ),
            ),
            Text(
              member.name,
              style: Constants.mediumText.copyWith(
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Container(
              height: 80,
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
    );
  }
}
