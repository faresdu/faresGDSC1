import 'package:gdsc_app/core/models/member.dart';
import 'package:stacked/stacked.dart';

import '../../core/app/app.locator.dart';
import '../../core/services/supabase_service.dart';

class LeaderboardViewModel extends BaseViewModel {
  final userService = locator<SupabaseService>();
  List<Member> members = [];

  getLeaderboard() async {
    members = await userService.getLeaderboardMembers();
    notifyListeners();
  }
}
