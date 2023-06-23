import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/member.dart';
import '../../../core/utils/constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.member,
    this.edit,
  });
  final Function()? edit;
  final Member member;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Constants.white,
        boxShadow: Constants.shadow7,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: Constants.shadow5),
                width: 80,
                height: 80,
                child: CircleAvatar(
                  backgroundImage:
                      member.photo != null ? NetworkImage(member.photo!) : const AssetImage('assets/images/event-attendees.png') as ImageProvider,
                  radius: 40,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      member.name,
                      style: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      '${member.getRole()} ${member.committee.name}',
                      style: GoogleFonts.cairo(
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Constants.grey),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: edit,
                icon: const Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 26,
          ),
          Row(
            children: [
              Expanded(
                child: buildProfileInfoBox(
                  number: member.events.length,
                  bottomText: 'المشاركات',
                ),
              ),
              Expanded(
                child: buildProfileInfoBox(
                  number: member.posts.length,
                  bottomText: 'المنشورات',
                ),
              ),
              Expanded(
                child: buildProfileInfoBox(
                  number: member.hours,
                  bottomText: 'الساعات',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildProfileInfoBox({required int number, required String bottomText}) {
    return Column(
      children: [
        Text(
          "$number",
          style: GoogleFonts.cairo(
            height: 1,
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          bottomText,
          style: GoogleFonts.cairo(
            height: 1,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Constants.grey,
          ),
        )
      ],
    );
  }
}
