import 'package:flutter/foundation.dart';
import 'package:gdsc_app/core/enums/tables.dart';
import 'package:gdsc_app/core/enums/views.dart';
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
    final List<Map<String, dynamic>> res = await _supabaseService.supabaseClient
        .from(GDSCTables.volunteerHours)
        .select('*, Users!inner(name, profile_picture)')
        .isFilter('approved', null)
        .match(payload);
    return res.map((e) => HourRequest.fromJson(e)).toList();
  }

  Future<List<HourRequest>> getPreviousHourRequests(String committeeId) async {
    final Map<String, dynamic> payload = {'committee_id': committeeId};
    final List<Map<String, dynamic>> res = await _supabaseService.supabaseClient
        .from(GDSCTables.volunteerHours)
        .select('*, Users!inner(name, profile_picture)')
        .not('approved', 'is', null)
        .match(payload);
    return res.map((e) => HourRequest.fromJson(e)).toList();
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
        .insert(payload);
    return VolunteerHours.fromJson(res.data.first);
  }

  Future<void> updateHourRequest(String id, bool status) async {
    try {
      await _supabaseService.supabaseClient
          .from(GDSCTables.volunteerHours)
          .update({'approved': status}).match({'volunteer_id': id});
    } catch (e) {
      throw 'Failed to updateHourRequest, ERROR : $e';
    }
  }

  Future<void> removeHourRequest(String id) async {
    try {
      await _supabaseService.supabaseClient
          .from(GDSCTables.volunteerHours)
          .delete()
          .match({'volunteer_id': id});
    } catch (e) {
      throw 'Failed to removeHourRequest, ERROR : $e';
    }
  }

  Future<int> getCumulativeCommitteeHours() async {
    final Map<String, dynamic> payload = {
      'committee_id': _userService.user.committee.id
    };
    try {
      final List<Map<String, dynamic>> res = await _supabaseService
          .supabaseClient
          .from(GDSCViews.leaderboard)
          .select('hours')
          .match(payload);
      final hours = res
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
      final List<Map<String, dynamic>> res = await _supabaseService
          .supabaseClient
          .from(GDSCViews.leaderboard)
          .select('hours')
          .match(payload);
      return res.first['hours'].toString().parseInt;
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
