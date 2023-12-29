import 'package:flutter/material.dart';

import '../../../core/models/post.dart';
import '../../../core/utils/constants.dart';

class PostContent extends StatelessWidget {
  const PostContent({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5, right: 8),
          child: Column(
            children: [
              Container(
                  alignment: const Alignment(1, 0),
                  margin: const EdgeInsets.only(right: 15, left: 15, top: 8),
                  child: Text(
                    post.content,
                    style: Constants.verySmallText
                        .copyWith(color: Constants.black),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
