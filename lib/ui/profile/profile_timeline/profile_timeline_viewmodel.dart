import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../core/app/app.locator.dart';
import '../../../core/models/post.dart';
import '../../../core/services/timeline_service.dart';
import '../../../core/services/user_service.dart';

class ProfileTimelineViewModel extends FutureViewModel {
  final userService = locator<UserService>();
  final timelineService = locator<TimelineService>();

  final key = GlobalKey(debugLabel: 'profile_timeline');

  List<Post> userPosts = [];
  List<Post> likedPosts = [];

  Future<void> getPosts() async {
    setBusy(true);
    userPosts = userService.user.posts;
    likedPosts = await timelineService.getLikedPosts();
    notifyListeners();
    setBusy(false);
  }

  void addToUserPosts(String postId) async {
    final post = await timelineService.getPost(postId);
    userPosts.add(post);
    userPosts.sort((a, b) =>
        b.createdAt.microsecondsSinceEpoch -
        a.createdAt.microsecondsSinceEpoch);
    notifyListeners();
  }

  @override
  Future futureToRun() => getPosts();

  _updateLikedPosts(Post post, {bool removeFromList = false}) {
    final index = likedPosts.indexWhere((e) => e.id == post.id);
    if (!removeFromList && index == -1) {
      likedPosts.add(post);
      likedPosts.sort((a, b) =>
          b.createdAt.microsecondsSinceEpoch -
          a.createdAt.microsecondsSinceEpoch);
    }
    if (index != -1 && removeFromList) {
      likedPosts.remove(post);
    }
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
      _updateLikedPosts(post);
      notifyListeners();
      await timelineService.likePost(post.id, userId);
    } catch (e) {
      print(e.toString());
      _like(post, userId, unlike: true);
      _updateLikedPosts(post, removeFromList: true);
    }
    notifyListeners();
  }

  unLikePost(Post post, String userId) async {
    try {
      _like(post, userId, unlike: true);

      _updateLikedPosts(post, removeFromList: true);
      notifyListeners();
      await timelineService.unLikePost(post.id, userId);
    } catch (e) {
      print(e.toString());
      _like(post, userId);
      _updateLikedPosts(post);
    }
    notifyListeners();
  }
}
