import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/leaderboard_member.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/services/supabase_service.dart';

class LeaderboardViewModel extends BaseViewModel {
  final userService = locator<SupabaseService>();
  final navService = locator<NavigationService>();

  List<LeaderboardMember> members = [];
  List<LeaderboardMember> top3Members = [];

  getLeaderboard() async {
    setBusy(true);
    List<LeaderboardMember> tempMembers =
        await userService.getLeaderboardMembers();
    top3Members = tempMembers.sublist(0, 3);
    members = tempMembers.sublist(3);
    print('fetched leaderboard members, $members');
    setBusy(false);
    notifyListeners();
  }

  navigateToHierarchy() {
    navService.navigateTo(Routes.hierarchyView);
  }

  navigateToUserProfile(String id) {
    navService.navigateTo(Routes.profileView, arguments: id);
  }

  String userName(String userName) {
    if (userName.length > 14) {
      return '...${userName.substring(0, 14)}';
    }
    return userName;
  }

  Future<void> refreshData() async {
    setBusy(true);
    await getLeaderboard();
    notifyListeners();
    setBusy(false);
  }

  static String shortcutName(String shortcutNamee) {
    if (shortcutNamee.length > 16) {
      return '${shortcutNamee.substring(0, 16)}...';
    }
    return shortcutNamee;
  }
}
