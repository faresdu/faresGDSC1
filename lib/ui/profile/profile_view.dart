import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/models/member.dart';
import '../../core/utils/constants.dart';
import 'components/profile_social_media_card.dart';
import 'components/profile_volunteer_hours_card.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            body: viewmodel.hasError
                ? Text(viewmodel.modelError!)
                : SafeArea(
                    child: viewmodel.isBusy
                        ? const CircularProgressIndicator()
                        : RefreshIndicator(
                            onRefresh: viewmodel.updateData,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: IconButton(
                                            onPressed: () async {
                                              await viewmodel.signOut();
                                            },
                                            icon: const Icon(Icons.logout_rounded, size: 40),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 7,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 7),
                                            child: Center(
                                              child: Text(
                                                'المـلـف الـشـخـصـي',
                                                style: GoogleFonts.cairo(
                                                  textStyle: const TextStyle(
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    buildProfileCard(viewmodel.data!),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: buildProfileButton(
                                                isSelected: index == 0,
                                                icon: Icons.account_box_rounded,
                                                bottomText: 'الفعاليات',
                                                onPressed: () {
                                                  setState(() {
                                                    index = 0;
                                                  });
                                                }),
                                          ),
                                          Flexible(
                                            child: buildProfileButton(
                                                isSelected: index == 1,
                                                icon: Icons.access_time,
                                                bottomText: 'الساعات',
                                                onPressed: () {
                                                  setState(() {
                                                    index = 1;
                                                  });
                                                }),
                                          ),
                                          Flexible(
                                            child: buildProfileButton(
                                                isSelected: index == 2,
                                                icon: Icons.newspaper,
                                                bottomText: 'المنشورات',
                                                onPressed: () {
                                                  setState(() {
                                                    index = 2;
                                                  });
                                                }),
                                          ),
                                          Flexible(
                                            child: buildProfileButton(
                                                isSelected: index == 3,
                                                icon: Icons.chat,
                                                bottomText: 'التواصل',
                                                onPressed: () {
                                                  setState(() {
                                                    index = 3;
                                                  });
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: Constants.grey,
                                      thickness: 1,
                                      height: 30,
                                    ),
                                    IndexedStack(
                                      index: index,
                                      children: [
                                        Column(
                                            children: viewmodel.data!.events
                                                .map(
                                                  (e) => Placeholder(
                                                    child: Text(e.title),
                                                  ),
                                                )
                                                .toList()),
                                        Column(
                                            children: viewmodel.data!.volunteerHours
                                                .map(
                                                  (e) => ProfileVolunteerHoursCard(volunteerHours: e),
                                                )
                                                .toList()),
                                        Column(
                                            children: viewmodel.data!.socials
                                                .map(
                                                  (e) => const Placeholder(),
                                                )
                                                .toList()),
                                        Column(
                                            children: viewmodel.data!.socials
                                                .map(
                                                  (e) => Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                                                    child: ProfileSocialMediaCard(socialMedia: e),
                                                  ),
                                                )
                                                .toList()),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ),
          );
        });
  }

  Widget buildProfileCard(Member member) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        boxShadow: Constants.shadow6,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Constants.profileColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                right: 20,
                bottom: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        member.photo != null ? NetworkImage(member.photo!) : const AssetImage('assets/images/event-attendees.png') as ImageProvider,
                    radius: 45.0,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          member.name,
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Text(
                          '${member.getRole()} ${member.committee.name}',
                          style: GoogleFonts.cairo(
                            textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Constants.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 9,
            ),
            color: Constants.white,
            child: Row(
              children: [
                Expanded(
                  child: buildProfileInfoBox(
                    number: member.events.length,
                    bottomText: 'المشاركات',
                  ),
                ),
                Expanded(
                  child: buildProfileInfoBox(
                    number: 4,
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

  Widget buildProfileButton({required IconData icon, required String bottomText, Function()? onPressed, required bool isSelected}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: isSelected ? Constants.darkBlue : Constants.darkBlue.withOpacity(.4),
          child: IconButton(
            iconSize: 30,
            icon: Icon(
              icon,
              color: Constants.white,
            ),
            onPressed: onPressed,
          ),
        ),
        Text(
          bottomText,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Constants.grey,
          ),
        ),
      ],
    );
  }
}
