import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/hours_approval/components/request_pop_up_menu.dart';

import '../../../core/models/hour_request.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/helper_functions.dart';

class RequestHeader extends StatelessWidget {
  const RequestHeader({
    super.key,
    required this.request,
    required this.onUpdate,
  });

  final HourRequest request;
  final Function(HourRequest request, bool status)? onUpdate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RequesterAvatar(avatar: request.userAvatar),
            const SizedBox(
              width: 10,
            ),
            Text(
              request.userName,
              style: Constants.smallText.copyWith(
                color: Constants.black,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        RequestPopUpMenu(request: request, onUpdate: onUpdate),
      ],
    );
  }
}

class RequesterAvatar extends StatelessWidget {
  const RequesterAvatar({
    super.key,
    this.avatar,
  });

  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: HelperFunctions.avatarImageProvider(imageUrl: avatar ?? ''),
            fit: BoxFit.fill),
        shape: BoxShape.circle,
      ),
    );
  }
}
