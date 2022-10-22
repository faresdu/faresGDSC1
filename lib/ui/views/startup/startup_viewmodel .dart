import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();
  final supabaseService = locator<SupabaseService>();

  navigateToLogin() {
    navService.navigateTo(Routes.loginView);
  }

  checkUser() async {
    if (await supabaseService.getCurrentUser() != null) {
      navService.navigateTo(Routes.navigationView);
    }
  }
}
