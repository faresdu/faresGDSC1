import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';

import '../app/app.locator.dart';

class AuthenticationService {
  final _supabaseService = locator<SupabaseService>();
  final _userService = locator<UserService>();

  Future<void> loginWithEmail(
      {required String email, required String password}) async {
    try {
      AuthResponse response =
          await _supabaseService.supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      //Store Current Session
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
        'PERSIST_SESSION_KEY',
        response.session!.accessToken,
      );
      await setUser();
      print('Login Successfully : ${response.user?.email}');
    }
    //Authentication Error Catch
    on AuthException catch (e) {
      throw 'Authentication Failed : ${e.message}';
      //Unknown Error
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Unknown Authentication, ERROR : $e';
    }
  }

  Future setUser() async {
    User? u = _supabaseService.supabaseClient.auth.currentUser;
    if (u != null) {
      await _userService.initUser(u.id);
    } else {
      print('user not initialized');
      throw '';
    }
  }

  Future<void> signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('PERSIST_SESSION_KEY');
      await _supabaseService.supabaseClient.auth.signOut();

      print('Signed out Successfully');
    } catch (e, sT) {
      await Sentry.captureException(
        e,
        stackTrace: sT,
      );
      throw 'Failed to sign out, ERROR : $e';
    }
  }

  Future<void> resetPassword(email) async {
    print(email);
    try {
      await _supabaseService.supabaseClient.auth.resetPasswordForEmail(email);
    } catch (e) {
      print(e);
      throw 'Failed to reset password, ERROR : $e';
    }
  }
}
