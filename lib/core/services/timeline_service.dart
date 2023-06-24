import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:supabase/supabase.dart';
import '../app/app.locator.dart';
import '../models/post.dart';

class TimelineService {
  final _supabaseService = locator<SupabaseService>();
  Future<List<Post>> getPosts() async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from('posts_view')
          .select('*')
          .order("created_at", ascending: false)
          .execute();
      print(res.data.first);
      return (res.data as List).map((e) => Post.fromJson(e)).toList();
    } catch (e) {
      throw 'Failed to get Posts, ERROR : $e';
    }
  }

  Future<dynamic> addPost(String content, String userId) async {
    final payload = {'user_id': userId, 'post_content': content};

    final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient
        .from('posts')
        .insert(payload)
        .execute();
    if (res.status != null && (res.status! < 200 || res.status! > 299)) {
      throw 'Failed to create post';
    }
    return (res.data as List).first;
  }

  likePost(String postId, String userId) async {
    try {
      final payload = {'post_id': postId, 'user_id': userId};
      final res = await _supabaseService.supabaseClient
          .from('post_likes')
          .insert(payload)
          .execute();
      print(res.status);
      if (res.status! > 299 || res.status! < 200) {
        print('erroooooor');
        throw Error();
      }
      ;
    } catch (e) {
      throw 'Failed to unLike Post, ERROR : $e';
    }
  }

  unLikePost(String postId, String userId) async {
    try {
      final payload = {'post_id': postId, 'user_id': userId};
      final res = await _supabaseService.supabaseClient
          .from('post_likes')
          .delete()
          .match(payload)
          .execute();
      if (res.status! > 299 || res.status! < 200) throw 'Error';
    } catch (e) {
      throw 'Failed to unLike Post, ERROR : $e';
    }
  }
}
