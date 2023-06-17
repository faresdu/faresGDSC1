import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdsc_app/core/services/authentication_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/app/app.locator.dart';
import '../../core/app/app.router.dart';
import '../../core/models/member.dart';
import '../../core/services/user_service.dart';
import '../../core/utils/constants.dart';
import 'components/profile_event_card.dart';
import 'components/profile_social_media_card.dart';
import 'components/profile_volunteer_hours_card.dart';

class ProfileViewModel extends BaseViewModel {
  final authService = locator<AuthenticationService>();
  final userService = locator<UserService>();
  final navService = locator<NavigationService>();

  int index = 0;
  late Member user;
  late StreamSubscription listener;

  listenToUser() {
    user = userService.user;
    listener = userService.userSubject.listen((e) => user = e as Member);
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  Future<void> refreshData() async {
    setBusy(true);
    await userService.updateUser();
    print(user.events);
    notifyListeners();
    setBusy(false);
  }

  Future<void> signOut() async {
    await authService.signOut();
    navService.clearStackAndShow(Routes.loginView);
  }

  Widget getBottomWidget() {
    if (index == 0) {
      return GridView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          children: user.events
              .map(
                (e) => ProfileEventCard(event: e),
              )
              .toList());
    } else if (index == 1) {
      return GridView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          children: user.volunteerHours.map((e) {
            if (e.isPending()) {
              return ProfileVolunteerHoursCard(volunteerHours: e);
            } else if (e.isApproved!) {
              return ProfileVolunteerHoursCard(volunteerHours: e);
            }
            return ProfileVolunteerHoursCard(volunteerHours: e);
          }).toList());
    } else if (index == 2) {
      return Column(
          children: user.posts
              .map(
                (e) => Text(e.content),
              )
              .toList());
    } else if (index == 3) {
      return Column(
          children: user.socials
              .map(
                (e) => ProfileSocialMediaCard(socialMedia: e),
              )
              .toList());
    }
    return Container();
  }

  List<Widget> getButtons() {
    return [
      Flexible(
        child: buildProfileButton(
            isSelected: index == 0,
            svgIcon: 'assets/icons/profile/timeline.svg',
            color: Constants.green,
            bottomText: 'الفعاليات',
            onPressed: () {
              index = 0;
              notifyListeners();
            }),
      ),
      Flexible(
        child: buildProfileButton(
            isSelected: index == 1,
            svgIcon: 'assets/icons/profile/timeline.svg',
            color: Constants.yellow,
            bottomText: 'الساعات',
            onPressed: () {
              index = 1;
              notifyListeners();
            }),
      ),
      Flexible(
        child: buildProfileButton(
            isSelected: index == 2,
            svgIcon: 'assets/icons/profile/timeline.svg',
            color: Constants.red,
            bottomText: 'المنشورات',
            onPressed: () {
              index = 2;
              notifyListeners();
            }),
      ),
      Flexible(
        child: buildProfileButton(
            isSelected: index == 3,
            svgIcon: 'assets/icons/profile/timeline.svg',
            color: Constants.blue,
            bottomText: 'التواصل',
            onPressed: () {
              index = 3;
              notifyListeners();
            }),
      ),
    ];
  }

  Widget buildProfileButton({
    required String svgIcon,
    required String bottomText,
    Function()? onPressed,
    required bool isSelected,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            color: isSelected ? color : Constants.grey.withOpacity(.4),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: IconButton(
            iconSize: 30,
            icon: SvgPicture.asset(svgIcon),
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

  void navigateToEditProfile() {
    navService.navigateTo(Routes.editProfileView);
  }
}
