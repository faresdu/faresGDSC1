import 'package:gdsc_app/core/models/gdsc_user.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:rxdart/rxdart.dart';

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
}
