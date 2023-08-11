// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import '../../core/models/post.dart';
import "../../core/utils/date_helper.dart";

class PostCard extends StatefulWidget {
  final Post post;
  final String userId;
  final Function(Post post, String userId) onLike;
  final Function(Post post, String userId) onUnLike;

  const PostCard({
    Key? key,
    required this.post,
    required this.onLike,
    required this.onUnLike,
    required this.userId,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    bool liked = isLiked();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, right: 20, left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: HelperFunctions.profileImage(
                          imageUrl: widget.post.posterProfilePicture ?? '',
                          height: 50,
                          width: 50),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.post.posterName,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w900)),
                        Row(
                          children: [
                            Text(" عضو اللجة التقنية  ",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Constants.grey)),
                            Padding(
                              padding: const EdgeInsets.only(top: 2, left: 6),
                              child: Icon(
                                Icons.fiber_manual_record,
                                size: 9,
                              ),
                            ),
                            Text(DateHelper.sincePosted(widget.post.createdAt),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Constants.black))
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                    alignment: Alignment(1, 0),
                    margin: EdgeInsets.only(right: 15, left: 15, top: 15),
                    child: Text(
                      widget.post.content,
                      style: TextStyle(fontSize: 16, color: Constants.black),
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: 10, left: 40, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('${widget.post.likes}'),
                      if (liked)
                        TextButton(
                            onPressed: () {
                              widget.onUnLike(widget.post, widget.userId);
                            },
                            child: Icon(
                              Icons.favorite,
                              color: Constants.red,
                            ))
                      else
                        TextButton(
                            onPressed: () {
                              widget.onLike(widget.post, widget.userId);
                            },
                            child: Icon(
                              Icons.favorite_border,
                              color: Constants.black,
                            )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 2,
            color: Constants.white,
          )
        ],
      ),
    );
  }

  bool isLiked() {
    if (widget.post.likerIds != null &&
        widget.post.likerIds!.isNotEmpty &&
        widget.post.likerIds!.contains(widget.userId)) {
      return true;
    }
    return false;
  }
}
