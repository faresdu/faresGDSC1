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

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      GotrueSessionResponse response = await supabaseClient.auth.signIn(
        email: email,
        password: password,
      );

      bool errorOccurred = response.error != null;

      //Authentication Error Occurred
      if (errorOccurred) {
        throw response.error!;

        //SignIn Successfully
      } else {
        //Store Current Session
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
          'PERSIST_SESSION_KEY',
          response.data!.persistSessionString,
        );

        print('Login Successfully : ${response.user?.email}');
      }

      //Authentication Error Catch
    } on GotrueError catch (e) {
      print('Login Failed : ${e.message}');
      //Unknown Error
    } catch (e) {
      print('Login Failed : ${e}');
    }
  }

  Future<User?> getCurrentUser() async {
    return await supabaseClient.auth.currentUser;
  }

  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
      print('Signed out Successfully');
    } catch (e) {
      throw 'Failed to sign out, ERROR : $e';
    }
  }
}

class SupabaseCredentials {
  static const String APIKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp2dWV1eGNlZXB1aGV0eHNhcXlwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjU1ODI3MTcsImV4cCI6MTk4MTE1ODcxN30.3WQNjKpe1Ny0UaBrYdiuRFH-hU2xd3HeZjHxAyxdeMQ';
  static const String APIUrl = 'https://jvueuxceepuhetxsaqyp.supabase.co';
}
