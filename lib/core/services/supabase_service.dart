import 'package:gdsc_app/core/enums/tables.dart';
import 'package:gdsc_app/core/enums/views.dart';
import 'package:gdsc_app/core/models/committee.dart';
import 'package:gdsc_app/core/models/gdsc_user.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';

import '../app/api-config.dart';
import '../models/leaderboard_member.dart';

class SupabaseService {
  static late SupabaseClient _supabaseClient;

  SupabaseClient get supabaseClient => _supabaseClient;

  static Future<void> initialize() async {
    _supabaseClient = SupabaseClient(
      APIConfig.supabaseAPIUrl,
      APIConfig.supabaseAPIKey,
    );

    try {
      await _restoreCurrentUser();
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      print('No Current User : $e');
    }
  }

  static Future<void> _restoreCurrentUser() async {
    try {
      //Pull PERSIST_SESSION_KEY
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? session = prefs.getString('PERSIST_SESSION_KEY');

      if (session != null) {
        //Recover Session
        AuthResponse response =
            await _supabaseClient.auth.recoverSession(session);

        prefs.setString('PERSIST_SESSION_KEY', response.session!.accessToken);
      }
      print(
          'Recovered Successfully : ${_supabaseClient.auth.currentUser?.email}');
    } on AuthException {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('PERSIST_SESSION_KEY');
    }
  }

  Future<List<Committee>> getCommittees() async {
    try {
      final List<Map<String, dynamic>> res =
          await supabaseClient.from(GDSCTables.committees).select();
      return res.map((e) => Committee.fromJson(e)).toList();
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to get Committees, ERROR : $e';
    }
  }

  Future<List<LeaderboardMember>> getLeaderboardMembers() async {
    try {
      final List<Map<String, dynamic>> res = await supabaseClient
          .from(GDSCViews.leaderboard)
          .select('*, Committees:committee_id(*)');
      return (res).map((e) => LeaderboardMember.fromJson(e)).toList();
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to get Leaderboard : $e';
    }
  }

  Future<List<Member>> getCommitteeMembers(String cId) async {
    try {
      final List<Map<String, dynamic>> res = await supabaseClient
          .from(GDSCViews.member)
          .select('*')
          .eq('committee_id', cId);
      // print(res.data);
      return res.map((e) => Member.fromJson(e)).toList();
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to get Committee Members, ERROR : $e';
    }
  }

  Stream<GDSCUser> subscribeToUser(String id) {
    return supabaseClient
        .from(GDSCViews.profile)
        .stream(primaryKey: [id]).asyncMap<GDSCUser>((event) {
      return getUser(id);
    });
  }

  Future<GDSCUser> getUser(String id) async {
    try {
      final res = await supabaseClient
          .from(GDSCViews.profile)
          .select('*')
          .eq('user_id', id)
          .single();
      // print(res.data);
      return GDSCUser.fromJson(res);
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to get User with id $id, ERROR : $e';
    }
  }

  Future<Member> getMember(String id) async {
    try {
      final res = await supabaseClient
          .from(GDSCViews.profile)
          .select('*')
          .eq('user_id', id)
          .single();
      return Member.fromJson(res);
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to get Member with id $id, ERROR : $e';
    }
  }

  Future<List<Member>> getMembers(List<String> memberIds) async {
    try {
      final res = await supabaseClient
          .from(GDSCTables.users)
          .select('*')
          .inFilter('user_id', memberIds);
      // print(res.data);
      return res.map((e) => Member.fromJson(e)).toList();
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to get Members, ERROR : $e';
    }
  }
}
