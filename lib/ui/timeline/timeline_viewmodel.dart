import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/gdsc_user.dart';
import 'package:gdsc_app/core/services/timeline_service.dart';
import 'package:stacked/stacked.dart';
import '../../core/app/app.locator.dart';
import '../../core/models/post.dart';

class TimeLineViewModel extends BaseViewModel {
  final timelineService = locator<TimelineService>();
  TextEditingController descriptionController = TextEditingController();

  List<Post> posts = [];

  Future<void> getPosts() async {
    setBusy(true);

    await timelineService.getPosts().then((value) => posts = value);
    notifyListeners();
    setBusy(false);
  }

  addPost(GDSCUser user) async {
    try {
      setBusy(true);
      await timelineService.addPost(
          descriptionController.value.text.trim(), user.id);
      await getPosts();
    } catch (e) {
      print(e.toString());
    }
    setBusy(false);
  }

  likePost(Post post, String userId) async {
    try {
      await timelineService.likePost(post.id, userId);
      post.likerIds?.add(userId);
      post.likes += 1;
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  unLikePost(Post post, String userId) async {
    try {
      await timelineService.unLikePost(post.id, userId);
      post.likerIds?.remove(userId);
      post.likes -= 1;
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }
}
