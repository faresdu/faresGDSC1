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
      List<Map<String, dynamic>> res;
      if (limit != null) {
        res = await _supabaseService.supabaseClient
            .from(GDSCViews.notifications)
            .select()
            .limit(limit)
            .order('created_at');
      } else {
        res = await _supabaseService.supabaseClient
            .from(GDSCViews.notifications)
            .select()
            .order('created_at');
      }
      return res.map((e) => Notifications.fromJson(e)).toList();
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
          .insert(notification.toJson());
      // print('added notification code: ${res.status}');
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
          .eq('notification_id', id);
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to delete Notification, ERROR : $e';
    }
  }
}
