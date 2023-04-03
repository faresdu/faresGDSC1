import 'package:gdsc_app/core/models/committee.dart';
import 'package:gdsc_app/core/models/gdsc_user.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';

class SupabaseService {
  late SupabaseClient supabaseClient;

  static Future<SupabaseService> getInstance() async {
    final service = SupabaseService();
    await service._initializeSupabase();
    return service;
  }

  Future<void> _initializeSupabase() async {
    supabaseClient = SupabaseClient(
      SupabaseCredentials.APIUrl,
      SupabaseCredentials.APIKey,
    );

    try {
      await _restoreCurrentUser();
    } catch (e) {
      print('No Current User : $e');
    }

    print(await getEvents());
  }

  Future<void> _restoreCurrentUser() async {
    //Pull PERSIST_SESSION_KEY
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? session = prefs.getString('PERSIST_SESSION_KEY');

    if (session != null) {
      //Recover Session
      GotrueSessionResponse response =
          await supabaseClient.auth.recoverSession(session);

      //Error Occurred
      if (response.error != null) {
        prefs.remove('PERSIST_SESSION_KEY');
      } else {
        prefs.setString(
            'PERSIST_SESSION_KEY', response.data!.persistSessionString);
      }
      print(
          'Recovered Successfully : ${supabaseClient.auth.currentUser?.email}');
    }
  }

  Future<dynamic> getEvents() async {
    try {
      final PostgrestResponse<dynamic> res =
          await supabaseClient.from('Events').select().execute();
      return res.data;
    } catch (e) {
      throw 'Failed to get Events, ERROR : $e';
    }
  }

  Future<List<Committee>> getCommittees() async {
    try {
      final PostgrestResponse<dynamic> res =
          await supabaseClient.from('Committees').select().execute();
      return (res.data as List).map((e) => Committee.fromJson(e)).toList();
    } catch (e) {
      throw 'Failed to get Committees, ERROR : $e';
    }
  }

  Future<List<Member>> getLeaderboardMembers() async {
    try {
      final PostgrestResponse<dynamic> res =
          await supabaseClient.from('leaderboard_view').select().execute();
      print('${res.data} ssssssssssss');
      return (res.data as List).map((e) => Member.fromJson(e)).toList();
    } catch (e) {
      throw 'Failed to get Leaderboard : $e';
    }
  }

  Future<Member> getMemberProfile(String id) async {
    try {
      final PostgrestResponse<dynamic> res = await supabaseClient
          .from('profile_view')
          .select()
          .eq('user_id', id)
          .single()
          .execute();
      print(id);
      print(res.data);
      return Member.fromJson(res.data);
    } catch (e) {
      throw 'Failed to get profile : $e';
    }
  }

  Future<List<Member>> getCommitteeMembers(String cId) async {
    try {
      final PostgrestResponse<dynamic> res = await supabaseClient
          .from('member_view')
          .select()
          .eq('committee_id', cId)
          .execute();
      // print(res.data);
      return (res.data as List).map((e) => Member.fromJson(e)).toList();
    } catch (e) {
      throw 'Failed to get Committee Members, ERROR : $e';
    }
  }

  Stream<GDSCUser> subscribeToUser(String id) {
    return supabaseClient
        .from('Users')
        .stream([id])
        .execute()
        .asyncMap<GDSCUser>((event) {
          return getUser(id);
        });
  }

  Future<GDSCUser> getUser(String id) async {
    try {
      final res = await supabaseClient
          .from('Users')
          .select()
          .eq('user_id', id)
          .single()
          .execute();
      return GDSCUser.fromJson(res.data);
    } catch (e) {
      throw 'Failed to get User with id $id, ERROR : $e';
    }
  }
}

class SupabaseCredentials {
  static const String APIKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp2dWV1eGNlZXB1aGV0eHNhcXlwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjU1ODI3MTcsImV4cCI6MTk4MTE1ODcxN30.3WQNjKpe1Ny0UaBrYdiuRFH-hU2xd3HeZjHxAyxdeMQ';
  static const String APIUrl = 'https://jvueuxceepuhetxsaqyp.supabase.co';
}
