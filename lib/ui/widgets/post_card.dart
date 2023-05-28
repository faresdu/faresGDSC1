import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import '../../core/models/post.dart';

class PostCard extends StatefulWidget {
  final Post post;
  final String userId;
  final Function(Post post, String userId) onLike;
  final Function(Post post, String userId) onUnLike;
  const PostCard(
      {Key? key,
      required this.post,
      required this.onLike,
      required this.onUnLike,
      required this.userId})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    bool liked = isLiked();

    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.black12),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: HelperFunctions.profileImage(
                    imageUrl: widget.post.posterProfilePicture ?? '',
                    height: 40,
                    width: 40),
              ),
              SizedBox(width: 20),
              Text(widget.post.posterName),
            ],
          ),
          Text(widget.post.content),
          Text('${widget.post.likes}'),
          if (liked)
            TextButton(
                onPressed: () {
                  widget.onUnLike(widget.post, widget.userId);
                },
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    'unLike',
                    style: TextStyle(fontSize: 20),
                  ),
                ))
          else
            TextButton(
                onPressed: () {
                  widget.onLike(widget.post, widget.userId);
                },
                child: Container(
                  color: Colors.blue,
                  child: Text(
                    'like',
                    style: TextStyle(fontSize: 20),
                  ),
                )),
        ],
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
