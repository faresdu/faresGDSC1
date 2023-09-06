import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';

import '../app/app.locator.dart';

class AuthenticationService {
  final _supabaseService = locator<SupabaseService>();
  final _userService = locator<UserService>();

  Future<void> loginWithEmail(
      {required String email, required String password}) async {
    try {
      GotrueSessionResponse response =
          await _supabaseService.supabaseClient.auth.signIn(
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
        await setUser();
        // _userService.initUser(supabaseClient.auth.currentUser!.id);

        print('Login Successfully : ${response.user?.email}');
      }

      //Authentication Error Catch
    } on GotrueError catch (e) {
      throw 'Authentication Failed : ${e.message}';

      //Unknown Error
    } catch (e) {
      throw 'Unknown Authentication, ERROR : $e';
    }
  }

  User? getCurrentUser() {
    return _supabaseService.supabaseClient.auth.currentUser;
  }

  Future setUser() async {
    try {
      User? u = getCurrentUser();
      if (u != null) {
        await _userService.initUser(u.id);
      } else {
        print('user not initialized');
        throw '';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('PERSIST_SESSION_KEY');
      await _supabaseService.supabaseClient.auth.signOut();
      print('Signed out Successfully');
    } catch (e) {
      throw 'Failed to sign out, ERROR : $e';
    }
  }
}
