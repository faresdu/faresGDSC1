import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/services/supabase_service.dart';

class LeaderboardViewModel extends BaseViewModel {
  final userService = locator<SupabaseService>();
  final navService = locator<NavigationService>();

  List<Member> members = [];

  getLeaderboard() async {
    members = await userService.getLeaderboardMembers();
    print('fetched leaderboard members, $members');
    notifyListeners();
  }

  navigateToHierarchy() {
    navService.navigateTo(Routes.hierarchyView);
  }
}
