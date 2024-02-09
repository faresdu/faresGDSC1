import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/timeline/components/post_content.dart';
import 'package:gdsc_app/ui/timeline/components/post_info.dart';
import 'package:gdsc_app/ui/timeline/components/post_options.dart';
import '../../../core/models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final String userId;
  final Function(Post post, String userId) onLike;
  final Function(Post post, String userId) onUnLike;
  final Function(Post post)? onDelete;
  final void Function()? onUserTap;

  const PostCard({
    Key? key,
    required this.post,
    required this.onLike,
    required this.onUnLike,
    required this.userId,
    this.onUserTap,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        boxShadow: Constants.shadow,
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        children: [
          PostInfo(
              post: post,
              userId: userId,
              onUserTap: onUserTap,
              onDelete: onDelete),
          PostContent(post: post),
          PostOptions(
            post: post,
            userId: userId,
            onLike: onLike,
            onUnLike: onUnLike,
          ),
        ],
      ),
    );
  }
}
