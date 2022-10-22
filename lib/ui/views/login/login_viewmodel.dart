import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/app/app.locator.dart';
import '../../../core/app/app.router.dart';
import '../../../core/services/supabase_service.dart';

class LoginViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();
  final supabaseService = locator<SupabaseService>();

  navigateToNavigation() async {
    await supabaseService.loginWithEmail(
        email: '439100000@student.ksu.edu.sa', password: '123456');
    print(
        'Current User : ${supabaseService.supabaseClient.auth.currentUser?.email}');
    navService.navigateTo(Routes.navigationView);
  }
}
