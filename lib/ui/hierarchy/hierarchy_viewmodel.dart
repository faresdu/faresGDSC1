import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/committee.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/services/user_service.dart';

class HierarchyViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();
  final userService = locator<SupabaseService>();
  List<Committee> comms = [];

  getMembers(String id) async {
    // final res=await userService.getCommitteeMembers(id);
    // return
  }

  getComms() async {
    await userService.getCommittees().then((value) => comms = value);
    notifyListeners();
  }

  navigateToCommittee(Committee committee) async {
    List<Member> members = await userService.getCommitteeMembers(committee.id);
    // print(members.toString());
    navService.navigateTo(Routes.committeeMembersView,
        arguments: [members, committee]);
  }
}
