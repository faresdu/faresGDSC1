import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/widgets/deletable_item_card.dart';
import 'package:gdsc_app/ui/profile/components/social_media_card.dart';

import '../../../core/models/user_social_media.dart';

class ProfileSocialMediaCard extends StatelessWidget {
  const ProfileSocialMediaCard(
      {super.key, required this.socialMedia, required this.onDelete});

  final UserSocialMedia socialMedia;
  final void Function(UserSocialMedia socialMedia) onDelete;
  @override
  Widget build(BuildContext context) {
    return DeletableItemCard<UserSocialMedia>(
      item: socialMedia,
      onDelete: onDelete,
      endAction: true,
      widget: SocialMediaCard(socialMedia: socialMedia),
    );
  }
}
