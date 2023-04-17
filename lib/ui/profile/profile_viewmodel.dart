import 'package:gdsc_app/core/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/app/app.locator.dart';
import '../../core/app/app.router.dart';
import '../../core/models/member.dart';
import '../../core/services/supabase_service.dart';
import '../../core/services/user_service.dart';

class ProfileViewModel extends FutureViewModel<Member> {
  final authService = locator<AuthenticationService>();
  final supabaseService = locator<SupabaseService>();
  final userService = locator<UserService>();
  final navService = locator<NavigationService>();

  getProfile() async {
    return await supabaseService.getMemberProfile(userService.user.id);
  }

  @override
  Future<Member> futureToRun() async {
    return await getProfile();
  }

  Future<void> signOut() async {
    await authService.signOut();
    navService.clearStackAndShow(Routes.loginView);
  }

  Future<void> updateData() async {
    data = await futureToRun();
    notifyListeners();
  }
}
