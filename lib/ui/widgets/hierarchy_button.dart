import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/committee.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';

class HierarchyButton extends StatelessWidget {
  final void Function() onPressed;
  final Committee committee;

  const HierarchyButton(
      {Key? key, required this.onPressed, required this.committee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: MaterialButton(
        elevation: 10,
        padding: const EdgeInsets.all(10),
        color: Constants.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: onPressed,
        child: Stack(alignment: Alignment.center, children: [
          if (committee.picture != null)
            Align(
              alignment: Alignment.centerRight,
              child: HelperFunctions.notificationImage(
                  imageUrl: committee.picture!, height: 45, width: 45),
            ),
          Text(committee.name,
              style: Constants.veryLargeText.copyWith(
                fontWeight: FontWeight.bold,
              )),
          const Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Constants.lightGrey,
              size: 30,
            ),
          )
        ]),
      ),
    );
  }
}
