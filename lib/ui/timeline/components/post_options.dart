import 'package:flutter/material.dart';

import '../../../core/models/post.dart';
import '../../../core/utils/constants.dart';

class PostOptions extends StatelessWidget {
  const PostOptions({
    super.key,
    required this.onUnLike,
    required this.post,
    required this.userId,
    required this.onLike,
  });

  final Function(Post post, String userId) onUnLike;
  final Post post;
  final String userId;
  final Function(Post post, String userId) onLike;

  @override
  Widget build(BuildContext context) {
    bool liked = isLiked();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: const Icon(
              Icons.comments_disabled_outlined,
              color: Constants.black2,
            ),
          ),
          Row(
            children: [
              if (liked)
                TextButton(
                    onPressed: () {
                      onUnLike(post, userId);
                    },
                    child: Row(
                      children: [
                        Text(
                          '${post.likes}',
                          style: Constants.smallText
                              .copyWith(color: Constants.black),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Icon(
                          Icons.favorite,
                          color: Constants.red,
                        )
                      ],
                    ))
              else
                TextButton(
                    onPressed: () {
                      onLike(post, userId);
                    },
                    child: Row(
                      children: [
                        Text(
                          '${post.likes}',
                          style: Constants.smallText
                              .copyWith(color: Constants.black),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Icon(
                          Icons.favorite_border,
                          color: Constants.black,
                        )
                      ],
                    )),
            ],
          )
        ],
      ),
    );
  }

  bool isLiked() {
    if (post.likerIds != null &&
        post.likerIds!.isNotEmpty &&
        post.likerIds!.contains(userId)) {
      return true;
    }
    return false;
  }
}
