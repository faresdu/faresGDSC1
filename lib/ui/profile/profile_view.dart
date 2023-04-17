import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/social_media.dart';
import 'package:gdsc_app/ui/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/constants.dart';

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
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(17.0),
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
                      const SizedBox(height: 45.0),
                      Container(
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
                                      backgroundImage: viewmodel.member.photo != null
                                          ? NetworkImage(viewmodel.member.photo!)
                                          : const AssetImage('assets/images/event-attendees.png') as ImageProvider,
                                      radius: 45.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            viewmodel.member.name,
                                            style: GoogleFonts.cairo(
                                              textStyle: const TextStyle(
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            viewmodel.getText(),
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
                                    child: buildProfileBox(
                                      number: 4,
                                      bottomText: 'المشاركات',
                                    ),
                                  ),
                                  Expanded(
                                    child: buildProfileBox(
                                      number: 4,
                                      bottomText: 'المنشورات',
                                    ),
                                  ),
                                  Expanded(
                                    child: buildProfileBox(
                                      number: 4,
                                      bottomText: 'الساعات',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: buildProfileIcon(
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
                              child: buildProfileIcon(
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
                              child: buildProfileIcon(
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
                              child: buildProfileIcon(
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
                      ),
                      IndexedStack(
                        index: index,
                        children: [
                          const Text('0'),
                          const Text('1'),
                          const Text('2'),
                          Column(
                              children: viewmodel.member.socials
                                  .map(
                                    (e) => ProfileSocialMediaCard(socialMedia: e),
                                  )
                                  .toList()),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildProfileIcon({
    required IconData icon,
    required String bottomText,
    Function()? onPressed,
    required bool isSelected,
  }) {
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

  Widget buildProfileBox({required int number, required String bottomText}) {
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

class ProfileSocialMediaCard extends StatelessWidget {
  const ProfileSocialMediaCard({
    super.key,
    required this.socialMedia,
  });

  final SocialMedia socialMedia;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              height: 80,
              color: Constants.profileColor.withOpacity(.8),
              child: IconButton(
                icon: const Icon(
                  Icons.navigate_next,
                  size: 50,
                  color: Constants.white,
                  textDirection: TextDirection.ltr,
                ),
                onPressed: () {},
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Constants.darkBlue,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(
                            widthFactor: 1,
                            child: Text(
                              socialMedia.name,
                              style: GoogleFonts.cairo(
                                textStyle: const TextStyle(
                                  color: Constants.white,
                                  height: 1.7,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                ),
                              ),
                            )),
                        Center(
                          widthFactor: 1,
                          child: Text(
                            'username@',
                            style: GoogleFonts.cairo(
                              textStyle: const TextStyle(
                                color: Constants.white,
                                height: 1,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.network(
                      socialMedia.image,
                      height: 65,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
