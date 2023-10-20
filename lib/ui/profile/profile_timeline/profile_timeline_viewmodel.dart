import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/timeline/add_post/posts_viewmodel.dart';

import '../../../core/app/app.locator.dart';
import '../../../core/models/member.dart';
import '../../../core/models/post.dart';
import '../../../core/services/timeline_service.dart';
import '../../../core/services/user_service.dart';
import '../../timeline/add_post/add_post_view.dart';
import '../../widgets/custom_bottom_modal_sheet.dart';

class ProfileTimelineViewModel extends PostsViewModel {
  final userService = locator<UserService>();
  final timelineService = locator<TimelineService>();

  final key = GlobalKey(debugLabel: 'profile_timeline');

  bool isUser = true;
  @override
  List<Post> posts = [];
  List<Post> likedPosts = [];

  Future<void> getPosts(BuildContext context) async {
    setBusy(true);
    Member? member = (ModalRoute
        .of(context)!
        .settings
        .arguments as Member?);
    if (member != null) {
      isUser = false;
    } else {
      member = userService.user;
    }
    posts = member.posts;

    likedPosts = await timelineService.getLikedPosts(id: member.id);
    notifyListeners();
    setBusy(false);
  }

  _updateLikedPosts(Post post, {bool removeFromList = false}) {
    final index = likedPosts.indexWhere((e) => e.id == post.id);
    if (isUser) {
      if (!removeFromList && index == -1) {
        likedPosts.add(post);
        likedPosts.sort((a, b) =>
        b.createdAt.microsecondsSinceEpoch -
            a.createdAt.microsecondsSinceEpoch);
      }
      if (removeFromList && index != -1) {
        likedPosts.remove(post);
      }
    } else if (!isUser && index != -1) {
      int uPIndex = posts.indexWhere((e) => e.id == post.id);
      if (uPIndex != -1) posts[uPIndex] = post;
      likedPosts[index] = post;
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

  navigateToAddPosts(BuildContext context) async {
    return await CustomModalBottomSheet(
        context,
        AddPostView(postsvm: this)
    );
  }
}
