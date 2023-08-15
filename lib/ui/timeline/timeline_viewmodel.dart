import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/gdsc_user.dart';
import 'package:gdsc_app/core/services/timeline_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/app/app.locator.dart';
import '../../core/models/post.dart';

class TimeLineViewModel extends BaseViewModel {
  final timelineService = locator<TimelineService>();
  final navService = locator<NavigationService>();
  TextEditingController descriptionController = TextEditingController();
  String? description;
  final formKey = GlobalKey<FormState>();
  List<Post> posts = [];

  Future<void> getPosts() async {
    setBusy(true);

    await timelineService.getPosts().then((value) => posts = value);
    notifyListeners();
    setBusy(false);
  }

  Future<String?> addPost(GDSCUser user) async {
    if (!formKey.currentState!.validate()) {
      return null;
    }
    //Success
    formKey.currentState?.save();
    String? postId;
    try {
      setBusy(true);
      postId = await timelineService.addPost(description!, user.id);
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

  navigateToMemberProfile(String posterId) {
    navService.navigateTo(Routes.profileView, arguments: posterId);
  }
}
