import 'package:gdsc_app/core/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/app/app.locator.dart';

class LoginViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();

  navigateToNavigation() {
    navService.navigateTo(Routes.navigationView);
  }
}
