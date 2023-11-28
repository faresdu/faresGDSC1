import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import '../../core/models/post.dart';
import "../../core/utils/date_helper.dart";

class PostCard extends StatefulWidget {
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
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    bool liked = isLiked();
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
          ///post info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: ClipOval(
                      child: HelperFunctions.profileImage(
                          imageUrl: widget.post.posterProfilePicture ?? '',
                          gender: widget.post.posterGender ?? "",
                          height: 50,
                          width: 50),
                    ),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: widget.onUserTap,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.post.posterName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w900)),
                        Text("${widget.post.committee?.name}",
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
                    DateHelper.daysSinceDate(widget.post.createdAt) >= 30
                        ? DateHelper.getDate(widget.post.createdAt)
                        : DateHelper.sincePosted(widget.post.createdAt),
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Constants.grey),
                  ),
                  if (widget.post.posterId == widget.userId)
                    SizedBox(
                      height: 20,
                      child: PopupMenuButton(
                          icon: const Icon(Icons.more_horiz),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          onSelected: (value) async {
                            if (value == 'delete') {
                              bool? confirmed =
                                  await HelperFunctions.warningDialog(context,
                                      title: 'حذف المنشور',
                                      content: 'هل انت متاكد من حذف المنشور؟');
                              if (confirmed != null &&
                                  confirmed == true &&
                                  widget.onDelete != null) {
                                widget.onDelete!(widget.post);
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
          ),

          ///post content
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 8),
                child: Column(
                  children: [
                    Container(
                        alignment: const Alignment(1, 0),
                        margin:
                            const EdgeInsets.only(right: 15, left: 15, top: 8),
                        child: Text(
                          widget.post.content,
                          style: Constants.verySmallText
                              .copyWith(color: Constants.black),
                        )),
                  ],
                ),
              ),
            ],
          ),

          /// Options

          Container(
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
                            widget.onUnLike(widget.post, widget.userId);
                          },
                          child: Row(
                            children: [
                              Text(
                                '${widget.post.likes}',
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
                            widget.onLike(widget.post, widget.userId);
                          },
                          child: Row(
                            children: [
                              Text(
                                '${widget.post.likes}',
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
          ),
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
