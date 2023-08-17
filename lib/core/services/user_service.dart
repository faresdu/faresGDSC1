import 'package:gdsc_app/core/enums/tables.dart';
import 'package:gdsc_app/core/models/gdsc_user.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:supabase/supabase.dart';

import '../app/app.locator.dart';

class UserService {
  late GDSCUser user;
  final _supabaseService = locator<SupabaseService>();
  late BehaviorSubject<GDSCUser> userSubject;

  Future<void> initUser(String id) async {
    userSubject = BehaviorSubject<GDSCUser>();
    final userStream = _supabaseService.subscribeToUser(id);

    userStream.listen(userSubject.sink.add);

    user = await userSubject.stream.first;
    print('set user with student id ${user.sID}');
    userSubject.sink.add(user);
    userSubject.stream.listen((newUser) {
      user = newUser;
    });
  }

  Future<void> updateUser() async {
    userSubject.sink.add(await _supabaseService.getUser(user.id));
  }

  Future<void> updateUserInfo({required String name, String? avatar}) async {
    Map<String, dynamic> payload = {"name": name};
    if (avatar != null) payload.addAll({'profile_picture': avatar});
    try {
      final PostgrestResponse<dynamic> res = await _supabaseService
          .supabaseClient
          .from(GDSCTables.users)
          .update(payload)
          .match({'user_id': user.id}).execute();
    } catch (e) {
      throw 'Failed to update User info, ERROR : $e';
    }
  }
}
