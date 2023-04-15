import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import '../../core/models/member.dart';
import 'package:url_launcher/url_launcher.dart';

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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12), //was 20
        ),
        color:
            cardBackgroundColor(), //(role=="قائد")? Color(0xFFF9EEED):(role=="نائب القائد")? Color(0xFFFDF9EE): Color(0xFFF6FAFC),
        border: Border.all(
          color:
              borderColor(), //(role=="قائد")? Color(0xFFA0461A):(role=="نائب القائد")? Color(0xFFE7B94A): Color(0xFF0682BC),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 0.25,
            blurRadius: 7,
          ),
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: onPressed,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ///Profile Image
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    //container to add the colored border with shadow
                    decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            borderColor(), //(role=="قائد")? Color(0xFFA0461A):(role=="نائب القائد")? Color(0xFFE7B94A): Color(0xFF0682BC),
                        width: 0.5,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0.25,
                          blurRadius: 7,
                        ),
                      ],
                    ),

                    child: ClipOval(child: profileImage()),
                  ),
                ),
                /// Member Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(member.name,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    Text(role ?? 'عضو',
                        style: TextStyle(fontSize: 13, color: Colors.black)),
                    if (member.major != null)
                      Text(member.major!,
                          style: TextStyle(fontSize: 13, color: Colors.black))
                  ],
                )
              ],
            ),

            if (member.socials != null || member.socials!.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Divider(color: Color.fromARGB(191, 217, 217, 217)),
              ),

            /// Social Media icons
            if (member.socials != null || member.socials!.isEmpty)
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      member.socials!.map((e) => socialImage(e.image)).toList())
          ],
        ),
      ),
    );
  }

  Widget socialImage(image) {
    return GestureDetector(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.all(2.0),
          child: HelperFunctions.socialMediaImage(url: image)),
      onTap: () async {
        //launchUrl(Uri.parse('https://www.google.com'));
        // print('reached sovials');
        // if (!await launchUrl(Uri.parse('https://www.google.com'))) {
        //   throw Exception('Could not launch link');
        // }
      },
    );
  }

  Widget profileImage() {
    if (member.photo != null && member.photo!.isNotEmpty) {
      return HelperFunctions.profileImage(
          imageUrl: member.photo!,
          height: 65, //was 50
          width: 65, //was 50
          fit: BoxFit.cover);
    }
    return Image.asset(
      "assets/images/man.png",
      height: 65,
      width: 65,
      fit: BoxFit.cover,
    );
  }

  Color cardBackgroundColor() {
    return (role == "قائد")
        ? Color(0xFFF9EEED)
        : (role == "نائب القائد")
            ? Color(0xFFFDF9EE)
            : Color(0xFFF6FAFC);
  }

  Color borderColor() {
    return (role == "قائد")
        ? Color(0xFFA0461A)
        : (role == "نائب القائد")
            ? Color(0xFFE7B94A)
            : Color(0xFF0682BC);
  }
}
