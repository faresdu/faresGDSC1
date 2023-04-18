import 'package:flutter/material.dart';
import 'package:gdsc_app/core/services/authentication_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/app/app.locator.dart';
import '../../core/app/app.router.dart';
import '../../core/models/member.dart';
import '../../core/services/supabase_service.dart';
import '../../core/services/user_service.dart';
import '../../core/utils/constants.dart';
import 'components/profile_event_card.dart';
import 'components/profile_social_media_card.dart';
import 'components/profile_volunteer_hours_card.dart';

class ProfileViewModel extends FutureViewModel<Member> {
  final authService = locator<AuthenticationService>();
  final supabaseService = locator<SupabaseService>();
  final userService = locator<UserService>();
  final navService = locator<NavigationService>();

  int index = 0;
  late List<Widget> widgets = [
    GridView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: data!.events
            .map(
              (e) => ProfileEventCard(event: e),
            )
            .toList()),
    Column(
        children: data!.volunteerHours
            .map(
              (e) => ProfileVolunteerHoursCard(volunteerHours: e),
            )
            .toList()),
    Column(
        children: []
            .map(
              (e) => const Placeholder(),
            )
            .toList()),
    Column(
        children: data!.socials
            .map(
              (e) => ProfileSocialMediaCard(socialMedia: e),
            )
            .toList()),
  ];

  @override
  Future<Member> futureToRun() async {
    return await supabaseService.getMemberProfile(userService.user.id);
  }

  Future<void> signOut() async {
    await authService.signOut();
    navService.clearStackAndShow(Routes.loginView);
  }

  Widget getBottomWidget() {
    return widgets[index];
  }

  List<Widget> getButtons() {
    return [
      Flexible(
        child: buildProfileButton(
            isSelected: index == 0,
            icon: Icons.account_box_rounded,
            bottomText: 'الفعاليات',
            onPressed: () {
              index = 0;
              notifyListeners();
            }),
      ),
      Flexible(
        child: buildProfileButton(
            isSelected: index == 1,
            icon: Icons.access_time,
            bottomText: 'الساعات',
            onPressed: () {
              index = 1;
              notifyListeners();
            }),
      ),
      Flexible(
        child: buildProfileButton(
            isSelected: index == 2,
            icon: Icons.newspaper,
            bottomText: 'المنشورات',
            onPressed: () {
              index = 2;
              notifyListeners();
            }),
      ),
      Flexible(
        child: buildProfileButton(
            isSelected: index == 3,
            icon: Icons.chat,
            bottomText: 'التواصل',
            onPressed: () {
              index = 3;
              notifyListeners();
            }),
      ),
    ];
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
