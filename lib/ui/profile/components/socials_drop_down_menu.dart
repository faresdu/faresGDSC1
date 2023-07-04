import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/social_media.dart';

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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          DropdownButtonHideUnderline(
              child: DropdownButtonFormField(
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                fillColor: Colors.white,
                filled: true,
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                )),
            onChanged: onChanged,
            validator: (val) {
              if (val == null) {
                return 'الرجاء اختيار المنصه';
              }
              return null;
            },
            hint: const Text('اختر',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                )),
            items: socialMedias
                .map((e) => DropdownMenuItem(
                      value: e.id,
                      child: Row(
                        children: [
                          Text(
                            e.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
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
          ))
        ],
      ),
    );
  }
}
