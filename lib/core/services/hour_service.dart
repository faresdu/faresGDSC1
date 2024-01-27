import 'package:flutter/foundation.dart';
import 'package:gdsc_app/core/enums/tables.dart';
import 'package:gdsc_app/core/enums/views.dart';
import 'package:gdsc_app/core/models/committee.dart';
import 'package:gdsc_app/core/models/hour_request.dart';
import 'package:gdsc_app/core/models/volunteer_hours.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:gdsc_app/core/utils/string_extensions.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase/supabase.dart';

import '../app/app.locator.dart';

class HourService {
  final _supabaseService = locator<SupabaseService>();
  final _userService = locator<UserService>();

  Future<List<HourRequest>> getUpcomingHourRequests(String committeeId) async {
    final Map<String, dynamic> payload = {'committee_id': committeeId};
    final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient
        .from(GDSCTables.volunteerHours)
        .select('*, Users!inner(name, profile_picture)')
        .is_('approved', null)
        .match(payload)
        .execute();
    return (res.data as List).map((e) => HourRequest.fromJson(e)).toList();
  }

  Future<List<HourRequest>> getPreviousHourRequests(String committeeId) async {
    final Map<String, dynamic> payload = {'committee_id': committeeId};
    final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient
        .from(GDSCTables.volunteerHours)
        .select('*, Users!inner(name, profile_picture)')
        .not('approved', 'is', null)
        .match(payload)
        .execute();
    return (res.data as List).map((e) => HourRequest.fromJson(e)).toList();
  }

  Future<VolunteerHours> sendHourRequest(String reason, int hours) async {
    final Map<String, dynamic> payload = {
      'committee_id': _userService.user.committee.id,
      'user_id': _userService.user.id,
      'hours': hours,
      'reasoning': reason
    };
    final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient
        .from(GDSCTables.volunteerHours)
        .insert(payload)
        .execute();
    return VolunteerHours.fromJson(res.data.first);
  }

  Future<void> updateHourRequest(String id, bool status) async {
    final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient
        .from(GDSCTables.volunteerHours)
        .update({'approved': status}).match({'volunteer_id': id}).execute();
    if (res.status != null && (res.status! < 200 || res.status! > 299)) {
      throw 'Unable to update Hour Request';
    }
  }

  Future<void> removeHourRequest(String id) async {
    final PostgrestResponse<dynamic> res = await _supabaseService.supabaseClient
        .from(GDSCTables.volunteerHours)
        .delete()
        .match({'volunteer_id': id}).execute();
    if (res.status != null && (res.status! < 200 || res.status! > 299)) {
      throw 'Unable to update Hour Request';
    }
  }

  Future<int> getCumulativeCommitteeHours() async {
    final Map<String, dynamic> payload = {
      'committee_id': _userService.user.committee.id
    };
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCViews.leaderboard)
          .select('hours')
          .match(payload)
          .execute();
      final hours = (res.data as List)
          .map((e) => (e['hours']).toString().parseInt)
          .fold(0, (int p, c) => p + c);
      return hours;
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      if (kDebugMode) {
        print(e);
      }
      return 0;
    }
  }

  Future<int> getCumulativeHours() async {
    final Map<String, dynamic> payload = {'user_id': _userService.user.id};
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCViews.leaderboard)
          .select('hours')
          .match(payload)
          .execute();
      return res.data.first['hours'].toString().parseInt;
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      if (kDebugMode) {
        print(e);
      }
      return 0;
    }
  }
}
