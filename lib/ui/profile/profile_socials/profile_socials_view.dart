import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/profile/components/profile_social_media_card.dart';
import 'package:gdsc_app/ui/profile/profile_socials/add_social_media_view.dart';
import 'package:gdsc_app/ui/profile/profile_socials/profile_socials_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/custom_bottom_modal_sheet.dart';
import 'package:stacked/stacked.dart';

import '../components/social_media_card.dart';

class ProfileSocialsView extends StatefulWidget {
  const ProfileSocialsView({Key? key}) : super(key: key);

  @override
  State<ProfileSocialsView> createState() => _ProfileSocialsViewState();
}

class _ProfileSocialsViewState extends State<ProfileSocialsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileSocialsViewModel>.reactive(
        viewModelBuilder: () => ProfileSocialsViewModel(context),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: 'منصات التواصل الاجتماعي',
            ),
            backgroundColor: Constants.background,
            body: SafeArea(
              child: BusyOverlay(
                isBusy: viewmodel.isBusy,
                child: ListView(
                  children: (viewmodel.isUser
                          ? viewmodel.socials.map((e) => ProfileSocialMediaCard(
                                socialMedia: e,
                                onDelete: viewmodel.deleteSocial,
                              ))
                          : viewmodel.socials
                              .map((e) => SocialMediaCard(socialMedia: e)))
                      .toList(),
                ),
              ),
            ),
            floatingActionButton: viewmodel.isUser
                ? FloatingActionButton(
                    onPressed: () {
                      CustomModalBottomSheet(
                          context,
                          AddSocialMediaView(
                            onSubmit: (val) =>
                                setState(() => viewmodel.socials.add(val)),
                          ));
                    },
                    backgroundColor: Constants.blueButton,
                    heroTag: 'addSocialTag',
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  )
                : null,
          );
        });
  }
}
