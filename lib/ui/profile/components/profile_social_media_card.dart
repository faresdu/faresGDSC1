import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/social_media.dart';
import '../../../core/utils/constants.dart';

class ProfileSocialMediaCard extends StatelessWidget {
  const ProfileSocialMediaCard({
    super.key,
    required this.socialMedia,
  });

  final SocialMedia socialMedia;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      height: 80,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              height: 80,
              color: const Color(0xFFBFDEF5),
              child: IconButton(
                icon: const Icon(
                  Icons.navigate_next,
                  size: 50,
                  color: Constants.white,
                  textDirection: TextDirection.ltr,
                ),
                onPressed: () {},
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Constants.darkBlue,
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
                                  color: Constants.white,
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
                                color: Constants.white,
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
                    child: CachedNetworkImage(
                      imageUrl: socialMedia.image,
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
