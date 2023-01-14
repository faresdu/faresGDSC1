import 'package:flutter/material.dart';

import '../../core/models/member.dart';

class MemberCard extends StatelessWidget {
  final void Function() onPressed;
  final Member member;
  final String? role;

  const MemberCard(
      {Key? key, required this.onPressed, required this.member, this.role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    getImage() {
      try {
        if (member.photo == null || member.photo!.isEmpty) {
          return Image.asset(
            "assets/images/man.png",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          );
        } else {
          return Image.network(
            member.photo!,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          );
        }
      } catch (e) {
        return Image.asset(
          "assets/images/man.png",
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        );
      }
    }

    return Container(
      margin: EdgeInsets.all(10),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: TextButton(
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // <-- Radius
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
              backgroundColor: Colors.grey),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(child: getImage()),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(member.name,
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  Text(role ?? 'عضو',
                      style: TextStyle(fontSize: 13, color: Colors.white))
                ],
              )
            ],
          )),
    );
  }
}
