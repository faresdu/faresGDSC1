import 'package:stacked/stacked.dart';

import '../../../core/models/post.dart';

abstract class PostsViewModel extends BaseViewModel {
  late List<Post> posts;
}