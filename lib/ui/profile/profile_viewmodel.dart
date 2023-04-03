import 'package:gdsc_app/core/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import '../../core/app/app.locator.dart';
import '../../core/models/member.dart';
import '../../core/services/supabase_service.dart';
import '../../core/services/user_service.dart';

class ProfileViewModel extends BaseViewModel {
  final authService = locator<AuthenticationService>();
  final supabaseService = locator<SupabaseService>();
  final userService = locator<UserService>();
  late Member profile = Member.anonymous();

  void getProfile() async {
    profile = await supabaseService.getMemberProfile(userService.user.id);
    notifyListeners();
  }

}