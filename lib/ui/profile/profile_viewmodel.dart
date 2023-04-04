import 'package:gdsc_app/core/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import '../../core/app/app.locator.dart';
import '../../core/models/member.dart';
import '../../core/services/supabase_service.dart';
import '../../core/services/user_service.dart';

class ProfileViewModel extends FutureViewModel<Member> {
  final authService = locator<AuthenticationService>();
  final supabaseService = locator<SupabaseService>();
  final userService = locator<UserService>();

  getProfile() async {
    return await supabaseService.getMemberProfile(userService.user.id);
  }

  @override
  Future<Member> futureToRun() async {
    return await getProfile();
  }

}