import 'package:flutter/cupertino.dart';
import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/services/timeline_service.dart';
import 'package:gdsc_app/ui/timeline/add_post/posts_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/app/app.locator.dart';
import '../../core/models/post.dart';
import '../widgets/custom_bottom_modal_sheet.dart';
import 'add_post/add_post_view.dart';

class TimeLineViewModel extends PostsViewModel {
  final timelineService = locator<TimelineService>();
  final navService = locator<NavigationService>();
  @override
  List<Post> posts = [];

  Future<void> getPosts() async {
    setBusy(true);
    await timelineService.getPosts().then((value) => posts = value);
    posts.sort((a, b) =>
        b.createdAt.microsecondsSinceEpoch -
        a.createdAt.microsecondsSinceEpoch);
    notifyListeners();
    setBusy(false);
  }

  navigateToAddPosts(BuildContext context) async {
    await CustomModalBottomSheet(
        context, AddPostView(postsvm: this), heightFactor: 0.75);
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
