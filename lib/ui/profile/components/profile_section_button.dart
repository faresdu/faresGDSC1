import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';

class ProfileSectionButton extends StatelessWidget {
  const ProfileSectionButton(
      {required this.title,
      required this.color,
      required this.icon,
      this.onTap,
      Key? key})
      : super(key: key);
  final void Function()? onTap;
  final String title;
  final Color color;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Constants.white,
              boxShadow: Constants.shadow,
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 13),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: color, width: 2)),
                      child: icon),
                  Text(
                    title,
                    style: Constants.largeText
                        .copyWith(fontWeight: FontWeight.w600),
                  )
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Constants.lightGrey,
              )
            ],
          )),
    );
  }
}
