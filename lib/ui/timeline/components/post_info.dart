import 'package:flutter/material.dart';

import '../../../core/models/post.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/date_helper.dart';
import '../../../core/utils/helper_functions.dart';

class PostInfo extends StatelessWidget {
  const PostInfo({
    super.key,
    this.onDelete,
    required this.post,
    required this.onUserTap,
    required this.userId,
  });

  final Post post;
  final String userId;
  final void Function()? onUserTap;
  final Function(Post post)? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: ClipOval(
                child: HelperFunctions.profileImage(
                    imageUrl: post.posterProfilePicture ?? '',
                    gender: post.posterGender ?? "",
                    height: 50,
                    width: 50),
              ),
            ),
            const SizedBox(width: 15),
            InkWell(
              onTap: onUserTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.posterName,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w900)),
                  Text("${post.committee?.name}",
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Constants.grey)),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              DateHelper.daysSinceDate(post.createdAt) >= 30
                  ? DateHelper.getDate(post.createdAt)
                  : DateHelper.sincePosted(post.createdAt),
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Constants.grey),
            ),
            if (post.posterId == userId)
              SizedBox(
                height: 20,
                child: PopupMenuButton(
                    icon: const Icon(Icons.more_horiz),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    onSelected: (value) async {
                      if (value == 'delete') {
                        bool? confirmed = await HelperFunctions.warningDialog(
                            context,
                            title: 'حذف المنشور',
                            content: 'هل انت متاكد من حذف المنشور؟');
                        if (confirmed != null &&
                            confirmed == true &&
                            onDelete != null) {
                          onDelete!(post);
                        }
                      }
                    },
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            value: 'delete',
                            child: Text(
                              'حذف المنشوره',
                              textAlign: TextAlign.center,
                              style: Constants.verySmallText.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Constants.red),
                            ),
                          )
                        ]),
              )
          ],
        ),
      ],
    );
  }
}
