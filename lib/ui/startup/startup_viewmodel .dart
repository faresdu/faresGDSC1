import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/app/app.locator.dart';
import '../../../core/app/app.router.dart';

class StartUpViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();

  navigateToLogin() {
    navService.navigateTo(Routes.loginView);
  }
}
