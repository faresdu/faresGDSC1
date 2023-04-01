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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///Profile Image
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(child: profileImage()),
                  ),

                  /// Member Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(member.name,
                          style: TextStyle(fontSize: 18, color: Colors.black)),
                      Text(role ?? 'عضو',
                          style: TextStyle(fontSize: 13, color: Colors.white)),
                      Text(member.major,
                          style: TextStyle(fontSize: 13, color: Colors.white))
                    ],
                  )
                ],
              ),

              /// Social Media icons
              if (member.socials != null)
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: member.socials!
                        .map((e) => socialImage(e.image))
                        .toList())
            ],
          )),
    );
  }

  Widget socialImage(image) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Image.network(
        image,
        height: 30,
      ),
    );
  }

  Widget profileImage() {
    if (member.photo != null && member.photo!.isNotEmpty) {
      return Image.network(
        member.photo!,
        height: 50,
        width: 50,
        fit: BoxFit.cover,
      );
    }
    return Image.asset(
      "assets/images/man.png",
      height: 50,
      width: 50,
      fit: BoxFit.cover,
    );
  }
}
