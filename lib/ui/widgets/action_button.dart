import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class ActionButton extends StatelessWidget {
  final void Function() onTap;
  final String? text;
  final bool isApprove;

  const ActionButton({
    Key? key,
    required this.onTap,
    required this.isApprove,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          height: 30,
          width: 90,
          decoration: BoxDecoration(
            color: isApprove
                ? Constants.positive
                : Constants.cardBackground(context),
            border: isApprove
                ? null
                : Border.all(
                    color: Constants.negative,
                  ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: CircleAvatar(
                  backgroundColor:
                      isApprove ? Colors.white30 : Constants.negative,
                  child: Icon(
                    isApprove ? Icons.check : Icons.remove,
                    color: Constants.white,
                    size: 13,
                  ),
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                text ?? (isApprove ? 'قبول' : 'رفض'),
                style: Constants.verySmallText.copyWith(
                  color: isApprove ? Constants.white : Constants.black(context),
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
        ));
  }
}
