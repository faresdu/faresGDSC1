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
          .execute();
      print(res.data.first);
      return (res.data as List).map((e) => Post.fromJson(e)).toList();
    } catch (e) {
      throw 'Failed to get Posts, ERROR : $e';
    }
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
      if (res.status! > 299 || res.status! < 200) throw 'Error ';
    } catch (e) {
      throw 'Failed to unLike Post, ERROR : $e';
    }
  }
}
