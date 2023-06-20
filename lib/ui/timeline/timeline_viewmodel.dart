import 'package:flutter/material.dart';
import 'package:gdsc_app/core/services/timeline_service.dart';
import 'package:stacked/stacked.dart';

import '../../core/app/app.locator.dart';
import '../../core/models/post.dart';

class TimeLineViewModel extends BaseViewModel {
  final timelineService = locator<TimelineService>();
  TextEditingController descriptionController = TextEditingController();

  List<Post> posts = [];

  getPosts() async {
    await timelineService.getPosts().then((value) => posts = value);
    notifyListeners();
  }

  likePost(Post post, String userId) async {
    try {
      await timelineService.likePost(post.id, userId);
      post.likerIds?.add(userId);
      post.likes += 1;
    } catch (e) {
      AlertDialog(
        content: Text(e.toString()),
      );
    }
    notifyListeners();
  }

  unLikePost(Post post, String userId) async {
    try {
      await timelineService.unLikePost(post.id, userId);
      post.likerIds?.remove(userId);
      post.likes -= 1;

      notifyListeners();
    } catch (e) {
      AlertDialog(
        content: Text(e.toString()),
      );
    }
    notifyListeners();
  }
}
