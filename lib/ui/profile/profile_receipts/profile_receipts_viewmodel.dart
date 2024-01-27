import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/app/app.locator.dart';
import '../../../core/app/app.router.dart';

class ProfileReceiptsViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();

  navigateToBankAccounts() {
    navService.navigateTo(Routes.bankAccountView);
  }
}
