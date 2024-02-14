import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/gdsc_user.dart';
import 'package:gdsc_app/core/services/timeline_service.dart';
import 'package:gdsc_app/ui/timeline/add_post/posts_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../core/app/app.locator.dart';

class AddPostViewModel extends BaseViewModel {
  final timelineService = locator<TimelineService>();
  TextEditingController descriptionController = TextEditingController();
  String? description;
  final formKey = GlobalKey<FormState>();
  late PostsViewModel postsvm;

  setPosts(PostsViewModel postsvm) {
    this.postsvm = postsvm;
  }

  Future _addToPosts(String postId) async {
    print('adding post');
    final post = await timelineService.getPost(postId);
    print(post.id);
    postsvm.posts.add(post);
    postsvm.posts.sort((a, b) =>
        b.createdAt.microsecondsSinceEpoch -
        a.createdAt.microsecondsSinceEpoch);
    postsvm.notifyListeners();
  }

  Future<String?> addPost(GDSCUser user) async {
    if (!formKey.currentState!.validate()) {
      return null;
    }
    setBusy(true);
    //Success
    formKey.currentState?.save();
    String? postId;
    try {
      print("$description   ${user.id}");
      postId = await timelineService.addPost(description!, user.id);
      await _addToPosts(postId);
    } catch (e) {
      print(e.toString());
    }
    setBusy(false);
    return postId;
  }
}
