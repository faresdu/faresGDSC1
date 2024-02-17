import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/user_social_media.dart';
import '../../../core/utils/constants.dart';

class SocialMediaCard extends StatelessWidget {
  const SocialMediaCard({
    super.key,
    required this.socialMedia,
  });

  final UserSocialMedia socialMedia;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: MaterialButton(
        onPressed: () async {
          if (socialMedia.link != null) {
            HelperFunctions.openUrl(socialMedia.link!);
          }
        },
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Constants.cardBackground(context),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Constants.primary(context),
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          socialMedia.name,
                          style: Constants.veryLargeText.copyWith(
                            color: Constants.black(context),
                            height: 1.7,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "@${socialMedia.username}",
                          textDirection: TextDirection.ltr,
                          style: GoogleFonts.cairo(
                            textStyle: Constants.mediumText.copyWith(
                              color: Constants.black(context),
                              height: 1,
                              fontWeight: FontWeight.w700,
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
          ],
        ),
      ),
    );
  }
}
