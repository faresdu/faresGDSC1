import 'dart:async';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/core/services/authentication_service.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/app/app.router.dart';
import '../../core/models/member.dart';
import '../../core/services/s3_service.dart';
import '../../core/services/user_service.dart';
import '../../core/utils/constants.dart';

class ProfileViewModel extends BaseViewModel {
  final authService = locator<AuthenticationService>();
  final userService = locator<UserService>();
  final supabaseService = locator<SupabaseService>();
  final navService = locator<NavigationService>();
  final s3Service = locator<S3Service>();

  XFile? image;
  Map<String, String>? uploadedImageUrl;
  bool uploaded = false;
  bool added = false;
  String? oldImage;
  int index = 0;
  bool isUser = true;
  bool fromLogin = true;

  late Member user = Member.anonymous();
  StreamSubscription? listener;

  setUser(BuildContext context) async {
    setBusy(true);
    String? memberId = ModalRoute.of(context)!.settings.arguments as String?;
    Member userProfile = userService.user;
    if (memberId != null) {
      fromLogin = false;
    }
    if (memberId != null && memberId != userProfile.id) {
      try {
        user = await supabaseService.getMember(memberId);
        isUser = false;
      } catch (e) {
        print(e);
        user = Member.anonymous();
        isUser = false;
      }
    } else {
      user = userService.user;
      listener = userService.userSubject.listen((e) {
        user = e;
        notifyListeners();
      });
    }
    setBusy(false);
  }

  toggleDarkMode(BuildContext context) {
    EasyDynamicTheme.of(context)
        .changeTheme(dark: !Constants.isDarkMode(context));
    notifyListeners();
  }

  Future<bool?> showWarningDialog(BuildContext context) async {
    return await HelperFunctions.warningDialog(context,
        title: 'تسجيل الخروج',
        content: 'هل انت متاكد من تسجيل الخروج؟',
        confirmButtonText: 'نعم');
  }

  @override
  void dispose() {
    if (isUser) {
      listener!.cancel();
    }
    super.dispose();
  }

  Future<void> refreshData() async {
    setBusy(true);
    try {
      if (isUser) {
        await userService.updateUser();
      } else {
        user = await supabaseService.getMember(user.id);
      }
    } catch (e) {
      print('cant refresh data: $e');
    }
    notifyListeners();
    setBusy(false);
  }

  Future<void> signOut() async {
    try {
      await authService.signOut();
      navService.clearStackAndShow(Routes.loginView);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void navigateToEditProfile() {
    navService.navigateTo(Routes.editProfileView);
  }

  void navigateToProfileEvents() {
    navService.navigateTo(Routes.profileEventsView,
        arguments: isUser ? null : user);
  }

  void navigateToProfileUserHours() {
    navService.navigateTo(Routes.profileUserHoursView,
        arguments: isUser ? null : user);
  }

  void navigateToProfileTimeline() {
    navService.navigateTo(Routes.profileTimelineView,
        arguments: isUser ? null : user);
  }

  void navigateToProfileSocials() {
    navService.navigateTo(Routes.profileSocialsView,
        arguments: isUser ? null : user);
  }

  void navigateToProfileReceipts() {
    navService.navigateTo(Routes.profileReceiptsView);
  }
}
