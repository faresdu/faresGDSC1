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
    String? postId;
    try {
      setBusy(true);
      postId = await timelineService.addPost(
          descriptionController.value.text.trim(), user.id);
      await getPosts();
    } catch (e) {
      print(e.toString());
    }
    setBusy(false);
    return postId;
  }

  _like(Post post, String userId, {bool unlike = false}) {
    if (!unlike) {
      post.likerIds?.add(userId);
      post.likes++;
    } else {
      post.likerIds?.remove(userId);
      post.likes--;
    }
  }

  likePost(Post post, String userId) async {
    try {
      _like(post, userId);
      notifyListeners();
      await timelineService.likePost(post.id, userId);
    } catch (e) {
      print(e.toString());
      _like(post, userId, unlike: true);
    }
    notifyListeners();
  }

  unLikePost(Post post, String userId) async {
    try {
      _like(post, userId, unlike: true);
      notifyListeners();
      await timelineService.unLikePost(post.id, userId);
    } catch (e) {
      print(e.toString());
      _like(post, userId);
    }
    notifyListeners();
  }
}
