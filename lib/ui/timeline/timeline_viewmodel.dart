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
  int numPage = 1;
  final int numOfPostPerReq = 5;
  late int from;
  late int to;
  bool isLastPage = false;
  final int nextPageTrigger = 3;
  ScrollController scrollController = ScrollController();
  bool noMorePosts = false;
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void initTimeline() {
    initScroller();
    getPosts();
  }

  void initScroller() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          !noMorePosts) {
        getPosts();
      }
    });
  }

  Future<void> getPosts({bool resetPosts = false}) async {
    setBusy(true);
    if (resetPosts) {
      reset();
    } else {
      from = (numPage - 1) * 5;
      to = from + (numOfPostPerReq - 1);
    }

    await timelineService
        .getPosts(from, to)
        .then((value) => resetPosts ? posts = value : posts.addAll(value))
        .catchError((onError) => noMorePosts = true);
    isLastPage = posts.length < numOfPostPerReq;
    posts.sort((a, b) =>
        b.createdAt.microsecondsSinceEpoch -
        a.createdAt.microsecondsSinceEpoch);

    numPage += 1;
    notifyListeners();
    setBusy(false);
  }

  Future<void> reset() async {
    noMorePosts = false;
    numPage = 1;
    from = 0;
    to = (numOfPostPerReq - 1);
  }

  Future<void> refreshPost() async {
    getPosts(resetPosts: true);
  }

  Future _addToPosts(String postId) async {
    final post = await timelineService.getPost(postId);
    posts.insert(0, post);
    posts.sort((a, b) =>
        b.createdAt.microsecondsSinceEpoch -
        a.createdAt.microsecondsSinceEpoch);
    notifyListeners();
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
      await _addToPosts(postId);
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
