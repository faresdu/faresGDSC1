import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/models/user_social_media.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:stacked/stacked.dart';

import '../../../core/services/social_media_service.dart';

class ProfileSocialsViewModel extends BaseViewModel {
  final userService = locator<UserService>();
  final socialMediaService = locator<SocialMediaService>();
  late List<UserSocialMedia> socials;
  bool isUser = true;
  ProfileSocialsViewModel(BuildContext context) {
    Member? member = (ModalRoute.of(context)!.settings.arguments as Member?);
    if (member != null) {
      socials = member.socials;
      isUser = false;
    } else {
      socials = userService.user.socials;
    }
  }

  deleteSocial(UserSocialMedia socialMedia) async {
    setBusy(true);
    try {
      await socialMediaService.deleteSocialMedia(socialMedia.id!);
      socials.remove(socialMedia);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      socials.add(socialMedia);
    }
    setBusy(false);
  }
}
