import 'package:gdsc_app/core/enums/tables.dart';
import 'package:gdsc_app/core/enums/views.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
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
    } catch (e) {
      throw 'Failed to get Notifications, ERROR : $e';
    }
  }

  Future<void> addNotification(Notifications notification, String id) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.notifications)
          .insert(notification.toJson(id))
          .execute();
      print('added notification code: ${res.status}');
    } catch (e) {
      throw 'Failed to add Notification, ERROR : $e';
    }
  }
}
