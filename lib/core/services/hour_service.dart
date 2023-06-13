import 'package:gdsc_app/core/models/hour_request.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:supabase/supabase.dart';

import '../app/app.locator.dart';

class HourService {
  final _supabaseService = locator<SupabaseService>();
  final _userService = locator<UserService>();

  Future<List<HourRequest>> getUpcomingHourRequests() async {
    final Map<String, dynamic> payload = {
      'committee_id': _userService.user.committee!.id
    };
    final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient
        .from('volenteer_hours')
        .select('*, Users!inner(name, profile_picture)')
        .is_('approved', null)
        .match(payload)
        .execute();
    return (res.data as List).map((e) => HourRequest.fromJson(e)).toList();
  }

  Future<List<HourRequest>> getPreviousHourRequests() async {
    final Map<String, dynamic> payload = {
      'committee_id': _userService.user.committee!.id
    };
    final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient
        .from('volenteer_hours')
        .select('*, Users!inner(name, profile_picture)')
        .not('approved', 'is', null)
        .match(payload)
        .execute();
    return (res.data as List).map((e) => HourRequest.fromJson(e)).toList();
  }

  Future<void> updateHourRequest(String id, bool status) async {
    final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient
        .from('volenteer_hours')
        .update({'approved': status}).match({'volunteer_id': id}).execute();
    if (res.status != null && (res.status! < 200 || res.status! > 299)) {
      throw 'Unable to update Hour Request';
    }
  }
}
