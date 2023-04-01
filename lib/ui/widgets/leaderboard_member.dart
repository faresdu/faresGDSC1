import 'package:flutter/material.dart';

import '../../core/models/member.dart';

class LeaderboardMember extends StatelessWidget {
  final void Function() onPressed;
  final Member member;
  const LeaderboardMember(
      {required this.member, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [Text(member.name), Text(member.hours.toString())],
      ),
    );
  }
}
