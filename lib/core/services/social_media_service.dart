import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/enums/tables.dart';
import 'package:gdsc_app/core/models/social_media.dart';
import 'package:gdsc_app/core/models/user_social_media.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SocialMediaService {
  final _supabaseService = locator<SupabaseService>();
  final _userService = locator<UserService>();
  Future<List<SocialMedia>> getSupportedSocialMedias() async {
    try {
      final res = await _supabaseService.supabaseClient
          .from(GDSCTables.socialMedia)
          .select('*')
          .execute();
      if (res.error != null) {
        throw res.error!.message;
      }
      print(res.toJson());
      return (res.data as List).map((e) => SocialMedia.fromJson(e)).toList();
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to fetch social medias: $e';
    }
  }

  Future<UserSocialMedia> addSocialMedia(
      UserSocialMedia userSocialMedia) async {
    try {
      userSocialMedia.userId = _userService.user.id;
      final res = await _supabaseService.supabaseClient
          .from(GDSCTables.userSocials)
          .insert(userSocialMedia.toJson(toUserSocials: true))
          .execute();
      if (res.error != null) {
        throw res.error!.message;
      }
      return UserSocialMedia.fromJson(res.data.first);
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to insert social media: $e';
    }
  }

  Future<void> deleteSocialMedia(String socialId) async {
    try {
      final payload = {"social_id": socialId, "user_id": _userService.user.id};
      final res = await _supabaseService.supabaseClient
          .from(GDSCTables.userSocials)
          .delete()
          .match(payload)
          .execute();

      if (res.error != null) {
        throw res.error!.message;
      }
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to delete social media: $e';
    }
  }
}
