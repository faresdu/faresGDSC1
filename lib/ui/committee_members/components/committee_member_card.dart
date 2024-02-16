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
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: MaterialButton(
        onPressed: () => onTap!(member.id),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Constants.cardBackground(context),
        elevation: 4,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: ClipOval(
                child: HelperFunctions.profileImage(
                    imageUrl: member.photo ?? '',
                    gender: member.gender ?? "",
                    height: 55,
                    width: 55),
              ),
            ),
            Text(
              member.name,
              style: Constants.mediumText.copyWith(
                color: Constants.black(context),
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  color: Constants.primary(context),
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
