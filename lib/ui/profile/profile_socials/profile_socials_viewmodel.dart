import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/models/social_media.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:stacked/stacked.dart';

class ProfileSocialsViewModel extends BaseViewModel {
  final userService = locator<UserService>();
  late List<SocialMedia> socials;
  ProfileSocialsViewModel() {
    socials = userService.user.socials;
  }
}
