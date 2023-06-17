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
            .from('notifications_view')
            .select()
            .limit(limit)
            .execute();
      } else {
        res = await _supabaseService.supabaseClient
            .from('notifications_view')
            .select()
            .execute();
      }
      print('notifications: ${res.data}');
      return (res.data as List).map((e) => Notifications.fromJson(e)).toList();
    } catch (e) {
      throw 'Failed to get Notifications, ERROR : $e';
    }
  }

  Future<void> addNotification(Notifications notification, String id) async {
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from('notifications')
          .insert(notification.toJson(id))
          .execute();
      print('added notification code: ${res.status}');
    } catch (e) {
      throw 'Failed to add Notification, ERROR : $e';
    }
  }
}
