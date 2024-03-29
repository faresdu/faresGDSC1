import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/social_media.dart';

import '../../../core/utils/constants.dart';
import '../../widgets/custom_drop_down_menu.dart';

class SocialsDropDownMenu extends StatelessWidget {
  const SocialsDropDownMenu(
      {required this.title,
      required this.socialMedias,
      this.onChanged,
      Key? key})
      : super(key: key);
  final String title;

  final List<SocialMedia> socialMedias;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomDropDownMenu(
      title: title,
      errorMessage: 'الرجاء اختيار المنصه',
      hint: 'اختر',
      onChanged: onChanged,
      items: socialMedias
          .map((e) => DropdownMenuItem(
                value: e.id,
                child: Row(
                  children: [
                    Text(
                      e.name,
                      style: Constants.mediumText.copyWith(
                        color: Constants.black(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.network(e.image, width: 25)
                  ],
                ),
              ))
          .toList(),
    );
  }
}
