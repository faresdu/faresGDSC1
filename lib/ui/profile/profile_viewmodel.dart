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
import 'components/profile_volunteer_hours_card_big.dart';

class ProfileViewModel extends BaseViewModel {
  final authService = locator<AuthenticationService>();
  final userService = locator<UserService>();
  final navService = locator<NavigationService>();

  int index = 0;
  late Member user;
  late StreamSubscription listener;

  listenToUser() {
    user = userService.user;
    listener = userService.userSubject.listen((e) => user = e);
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

  void navigateToEditProfile() {
    navService.navigateTo(Routes.editProfileView);
  }

  Widget getTopWidget(BuildContext context) {
    if (index == 0) {
      return getTitle(
          title: 'اخر المشاركات',
          onPressed: () {
            navService.navigateTo(Routes.profileEventsView);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => Scaffold(
            //       backgroundColor: Constants.background,
            //       body: SafeArea(
            //         child: Column(
            //             children: user.events
            //                 .map(
            //                   (e) => ProfileEventCard(event: e),
            //                 )
            //                 .toList()),
            //       ),
            //     ),
            //   ),
            // );
          });
    } else if (index == 1) {
      return getTitle(
          title: 'اخر الأعمال',
          onPressed: () => navService.navigateTo(Routes.profileUserHoursView));
    } else if (index == 2) {
      return getTitle(
          title: 'اخر المنشورات',
          onPressed: () => navService.navigateTo(Routes.profileTimelineView));
    } else if (index == 3) {
      return getTitle(
          title: 'منصات التواصل',
          onPressed: () => navService.navigateTo(Routes.profileSocialsView));
    }
    return Container();
  }

  Widget getTitle({required String title, Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: GoogleFonts.cairo(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          MaterialButton(
            onPressed: onPressed,
            child: Text(
              "الكل",
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Constants.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBottomWidget() {
    if (index == 0) {
      return Column(
          children: user.events
              .take(3)
              .map(
                (e) => ProfileEventCard(
                  event: e,
                  onPressed: () {
                    navService.navigateTo(Routes.eventDetailsView,
                        arguments: e);
                  },
                ),
              )
              .toList());
    } else if (index == 1) {
      return GridView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          children: user.volunteerHours.take(6).map((e) {
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
        child: getProfileButton(
            isSelected: index == 0,
            child: const Icon(
              Icons.event_note_rounded,
              color: Constants.white,
            ),
            color: Constants.green,
            bottomText: 'الفعاليات',
            onPressed: () {
              index = 0;
              notifyListeners();
            }),
      ),
      Flexible(
        child: getProfileButton(
            isSelected: index == 1,
            child: const Icon(
              Icons.access_time,
              color: Constants.white,
            ),
            color: Constants.yellow,
            bottomText: 'الساعات',
            onPressed: () {
              index = 1;
              notifyListeners();
            }),
      ),
      Flexible(
        child: getProfileButton(
            isSelected: index == 2,
            child: SvgPicture.asset(
              'assets/icons/profile/timeline.svg',
              color: Constants.white,
            ),
            color: Constants.red,
            bottomText: 'المنشورات',
            onPressed: () {
              index = 2;
              notifyListeners();
            }),
      ),
      Flexible(
        child: getProfileButton(
            isSelected: index == 3,
            child: const Icon(
              Icons.chat_rounded,
              color: Constants.white,
            ),
            color: Constants.blue,
            bottomText: 'التواصل',
            onPressed: () {
              index = 3;
              notifyListeners();
            }),
      ),
    ];
  }

  Widget getProfileButton(
      {required Widget child,
      required String bottomText,
      Function()? onPressed,
      required bool isSelected,
      required Color color}) {
    return Column(
      children: [
        Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            color: isSelected ? color : Constants.grey.withOpacity(.4),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: IconButton(
            iconSize: 30,
            icon: child,
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
