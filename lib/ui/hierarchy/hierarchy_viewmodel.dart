import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/committee.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';

class HierarchyViewModel extends FutureViewModel {
  final navService = locator<NavigationService>();
  final userService = locator<SupabaseService>();
  List<Committee> committees = [];

  @override
  Future futureToRun() => getCommittees();

  getCommittees() async {
    await userService.getCommittees().then((value) => committees = value);
    notifyListeners();
  }

  navigateToCommittee(Committee committee) async {
    setBusy(true);
    List<Member> members = await userService.getCommitteeMembers(committee.id);
    setBusy(false);
    navService.navigateTo(Routes.committeeMembersView,
        arguments: [members, committee]);
  }
}
