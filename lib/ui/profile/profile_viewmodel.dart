import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/services/user_service.dart';

class ProfileViewModel extends BaseViewModel {
  final authService = locator<AuthenticationService>();
  final userService = locator<UserService>();
  final navService = locator<NavigationService>();

  Future<void> signOut() async {
    await authService.signOut();
    navService.clearTillFirstAndShow(Routes.loginView);
  }

  late final Member member = userService.user;

  String getText() {
    String type;
    if (member.id == member.committee?.leaderID) {
      type = "قائد";
    } else if (member.id == member.committee?.coLeaderID) {
      type = "نائب قائد";
    } else {
      type = 'عضو';
    }
    return '$type ${member.committee?.name}';
  }
}
