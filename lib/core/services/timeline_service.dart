import 'dart:convert';

import 'package:gdsc_app/core/enums/tables.dart';
import 'package:gdsc_app/core/enums/views.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase/supabase.dart';
import '../app/app.locator.dart';
import '../models/post.dart';

class TimelineService {
  final _supabaseService = locator<SupabaseService>();
  final _userService = locator<UserService>();
  Future<List<Post>> getPosts(int from, int to) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCViews.posts)
          .select('*, Committees:committee_id(*)')
          .range(from, to)
          .order('created_at', ascending: false)
          .execute();
      print(jsonEncode(res.data.first));
      return (res.data as List).map((e) => Post.fromJson(e)).toList();
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to get Posts, ERROR : $e';
    }
  }

  Future<Post> getPost(String postId) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCViews.posts)
          .select('*, Committees:committee_id(*)')
          .eq('id', postId)
          .execute();
      return (Post.fromJson((res.data as List).first));
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to get Posts, ERROR : $e';
    }
  }

  Future<List<Post>> getLikedPosts({String? id}) async {
    String userId = id ?? _userService.user.id;
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCViews.posts)
          .select('*, Committees:committee_id(*)')
          .contains("likers", '{"$userId"}')
          .order("created_at", ascending: false)
          .execute();
      if (res.data == null) throw 'User has no Liked Posts';
      return (res.data as List).map((e) => Post.fromJson(e)).toList();
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to get Liked Posts, ERROR : $e';
    }
  }

  Future<String> addPost(String content, String userId) async {
    final payload = {'user_id': userId, 'post_content': content};

    final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient
        .from(GDSCTables.posts)
        .insert(payload)
        .execute();
    if (res.status != null && (res.status! < 200 || res.status! > 299)) {
      throw 'Failed to create post';
    }
    return ((res.data as List).first)['post_id'];
  }

  likePost(String postId, String userId) async {
    try {
      final payload = {'post_id': postId, 'user_id': userId};
      final res = await _supabaseService.supabaseClient
          .from(GDSCTables.postLikes)
          .insert(payload)
          .execute();
      print(res.status);
      if (res.status! > 299 || res.status! < 200) {
        throw res.error!.message;
      }
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to unLike Post, ERROR : $e';
    }
  }

  unLikePost(String postId, String userId) async {
    try {
      final payload = {'post_id': postId, 'user_id': userId};
      final res = await _supabaseService.supabaseClient
          .from(GDSCTables.postLikes)
          .delete()
          .match(payload)
          .execute();
      if (res.status! > 299 || res.status! < 200) throw res.error!.message;
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to unLike Post, ERROR : $e';
    }
  }

  deletePost(String postId) async {
    try {
      final res = await _supabaseService.supabaseClient
          .from(GDSCTables.posts)
          .delete()
          .eq("post_id", postId)
          .execute();
      if (res.error != null) {
        throw res.error!;
      }
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to delete Post, ERROR : $e';
    }
  }
}
