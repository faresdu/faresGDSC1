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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Expanded(
        flex: 1,
        child: Container(
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, top: 8),
                alignment: AlignmentDirectional.topEnd,
                child: Text(
                  DateHelper.sincePosted(widget.post.createdAt),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Constants.grey),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18, right: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: ClipOval(
                                child: HelperFunctions.profileImage(
                                    imageUrl:
                                        widget.post.posterProfilePicture ?? '',
                                    height: 50,
                                    width: 50),
                              ),
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.post.posterName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900)),
                                Text(" عضو اللجة التقنية  ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Constants.grey)),
                              ],
                            ),
                          ],
                        ),
                        Container(
                            alignment: Alignment(1, 0),
                            margin:
                                EdgeInsets.only(right: 15, left: 15, top: 8),
                            child: Text(
                              widget.post.content,
                              style: TextStyle(
                                  fontSize: 14, color: Constants.black),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(bottom: 8, left: 40),
                alignment: AlignmentDirectional.bottomStart,
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
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isLiked() {
    if (widget.post.likerIds != null && widget.post.likerIds!.isNotEmpty) {
      for (var liker in widget.post.likerIds!) {
        print(liker);
        if (liker == widget.userId) return true;
      }
    }
    return false;
  }
}
