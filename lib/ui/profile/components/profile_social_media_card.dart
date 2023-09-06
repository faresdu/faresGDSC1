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
      height: 80,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: Constants.cardShadow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              height: 80,
              decoration: const BoxDecoration(
                color: Constants.darkBlue,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.navigate_next,
                  size: 50,
                  color: Constants.white,
                  textDirection: TextDirection.ltr,
                ),
                onPressed: () async {
                  if (socialMedia.link != null) {
                    HelperFunctions.openUrl(socialMedia.link!);
                  }
                },
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
                        Center(
                            widthFactor: 1,
                            child: Text(
                              socialMedia.name,
                              style: GoogleFonts.cairo(
                                textStyle: const TextStyle(
                                  color: Constants.black,
                                  height: 1.7,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28,
                                ),
                              ),
                            )),
                        Center(
                          widthFactor: 1,
                          child: Text(
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
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Image.network(
                      socialMedia.image,
                      height: 55,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
