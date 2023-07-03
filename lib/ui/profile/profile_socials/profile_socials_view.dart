import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/profile/components/profile_social_media_card.dart';
import 'package:gdsc_app/ui/profile/profile_socials/profile_socials_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:stacked/stacked.dart';

class ProfileSocialsView extends StatelessWidget {
  const ProfileSocialsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileSocialsViewModel>.reactive(
        viewModelBuilder: () => ProfileSocialsViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: 'منصات التواصل الاجتماعي',
            ),
            backgroundColor: Constants.background,
            body: SafeArea(
              child: Column(
                children: viewmodel.socials
                    .map((e) => ProfileSocialMediaCard(socialMedia: e))
                    .toList(),
              ),
            ),
          );
        });
  }
}
