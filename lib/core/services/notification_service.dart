import 'package:gdsc_app/core/enums/tables.dart';
import 'package:gdsc_app/core/enums/views.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase/supabase.dart';

import '../app/app.locator.dart';
import '../models/notifications.dart';

class NotificationService {
  final _supabaseService = locator<SupabaseService>();

  Future<List<Notifications>> getNotifications({int? limit}) async {
    try {
      PostgrestResponse<dynamic> res;
      if (limit != null) {
        res = await _supabaseService.supabaseClient
            .from(GDSCViews.notifications)
            .select()
            .limit(limit)
            .order('created_at')
            .execute();
      } else {
        res = await _supabaseService.supabaseClient
            .from(GDSCViews.notifications)
            .select()
            .order('created_at')
            .execute();
      }
      return (res.data as List).map((e) => Notifications.fromJson(e)).toList();
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to get Notifications, ERROR : $e';
    }
  }

  Future<void> addNotification(Notifications notification) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.notifications)
          .insert(notification.toJson())
          .execute();
      print('added notification code: ${res.status}');
      if (res.hasError) {
        print(res.error!.message);
        throw res.error!.message;
      }
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to add Notification, ERROR : $e';
    }
  }

  Future<void> deleteNotification(String id) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.notifications)
          .delete()
          .eq('notification_id', id)
          .execute();
      if (res.hasError) {
        throw res.error!.message;
      }
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to delete Notification, ERROR : $e';
    }
  }
}
