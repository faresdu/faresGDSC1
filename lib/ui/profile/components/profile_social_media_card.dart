import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import 'package:gdsc_app/ui/profile/components/social_media_card.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/user_social_media.dart';
import '../../../core/utils/constants.dart';

class ProfileSocialMediaCard extends StatelessWidget {
  const ProfileSocialMediaCard(
      {super.key, required this.socialMedia, required this.onDelete});

  final UserSocialMedia socialMedia;
  final void Function(UserSocialMedia socialMedia) onDelete;
  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const ScrollMotion(),
          children: [
            Builder(builder: (cont) {
              return ElevatedButton(
                onPressed: () {
                  onDelete(socialMedia);
                  Slidable.of(cont)?.close();
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: Constants.red.withOpacity(0.9),
                  padding: const EdgeInsets.all(14),
                ),
                child: const Icon(
                  Icons.delete,
                  color: Constants.white,
                  size: 26,
                ),
              );
            }),
          ],
        ),
        child: SocialMediaCard(socialMedia: socialMedia));
  }
}
