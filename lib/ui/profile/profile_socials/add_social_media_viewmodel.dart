import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/models/social_media.dart';
import 'package:gdsc_app/core/models/user_social_media.dart';
import 'package:gdsc_app/core/services/social_media_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:stacked/stacked.dart';

class AddSocialMediaViewModel extends FutureViewModel {
  final _socialMediaService = locator<SocialMediaService>();
  final userService = locator<UserService>();
  List<SocialMedia> socialMedias = [];
  final formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  String? selectedSocialId;
  String? userName;
  String? link;
  late Member user;

  getSocialMedias() async {
    user = userService.user;
    socialMedias = (await _socialMediaService.getSupportedSocialMedias())
        .where((e) => user.socials.where((e2) => e2.id == e.id).isEmpty)
        .toList();

    print(socialMedias);
    notifyListeners();
  }

  @override
  Future futureToRun() => getSocialMedias();

  addSocialMedia(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    //Success
    formKey.currentState?.save();
    final SocialMedia social =
        socialMedias.where((e) => e.id == selectedSocialId!).first;
    final req = UserSocialMedia(
        id: social.id,
        name: social.name,
        image: social.image,
        username: userName!,
        link: link);
    await _socialMediaService.addSocialMedia(req);
    userService.updateUser();
    return req;
  }
}
