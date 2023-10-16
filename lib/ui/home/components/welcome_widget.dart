import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import '../../../core/models/gdsc_user.dart';
import '../../../core/utils/constants.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  const Welcome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<GDSCUser>(context);
    return Row(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: Constants.memberIconShadow),
            child: ClipOval(
                child: HelperFunctions.profileImage(
                    imageUrl: user.photo ?? '', height: 65, width: 65))),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "أهلا ${user.name}",
              style: Constants.veryLargeText.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${user.isLeaderOrCoLeader() | user.isConsultant() ? user.getRole() : ''} ${user.committee.name}"
                  .trim(),
              style: Constants.smallText
                  .copyWith(height: 1, color: Constants.grey),
            ),
          ],
        ),
      ],
    );
  }
}
