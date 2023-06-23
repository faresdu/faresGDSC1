import 'package:flutter/material.dart';
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
                margin: const EdgeInsets.all(8),
                width: 65,
                height: 65,
                child: CircleAvatar(
                  backgroundImage: member.photo != null
                      ? NetworkImage(member.photo!)
                      : const AssetImage('assets/images/event-attendees.png')
                          as ImageProvider,
                  radius: 40,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: Constants.veryLargeText.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${member.getRole()} ${member.committee.name}',
                    style: Constants.smallText.copyWith(
                        fontWeight: FontWeight.w700, color: Constants.grey),
                  ),
                ],
              ),
              const Spacer(),
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

  Widget buildProfileInfoBox(
      {required int number, required String bottomText}) {
    return Column(
      children: [
        Text(
          "$number",
          style: Constants.veryLargeText.copyWith(
            height: 1,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(bottomText,
            style: Constants.smallText.copyWith(
              height: 1,
              fontWeight: FontWeight.w700,
              color: Constants.grey,
            ))
      ],
    );
  }
}
