import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/user_social_media.dart';
import '../../../core/utils/constants.dart';

class ProfileSocialMediaCard extends StatelessWidget {
  const ProfileSocialMediaCard({
    super.key,
    required this.socialMedia,
  });

  final UserSocialMedia socialMedia;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: ElevatedButton(
        onPressed:  () async {
          if (socialMedia.link != null) {
            HelperFunctions.openUrl(socialMedia.link!);
          }
        },
        clipBehavior: Clip.antiAlias,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Constants.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 80,
                decoration: const BoxDecoration(
                  color: Constants.darkBlue,
                ),
                child: const Icon(
                    Icons.navigate_next,
                    size: 50,
                    color: Constants.white,
                    textDirection: TextDirection.ltr,
                  ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                color: Constants.white,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            socialMedia.name,
                            style: GoogleFonts.cairo(
                              textStyle: const TextStyle(
                                color: Constants.black,
                                height: 1.7,
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                              ),
                            ),
                          ),
                          Text(
                            "@${socialMedia.username}",
                            textDirection: TextDirection.ltr,
                            style: GoogleFonts.cairo(
                              textStyle: const TextStyle(
                                color: Constants.black,
                                height: 1,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: HelperFunctions.socialMediaImage(
                        url: socialMedia.image,
                        height: 55,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
