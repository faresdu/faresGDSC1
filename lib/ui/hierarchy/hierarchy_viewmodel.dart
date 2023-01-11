import 'package:gdsc_app/core/models/committee.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/services/user_service.dart';

class HierarchyViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();
  final userService = locator<SupabaseService>();
  List<Committee> comms = [];

  getCommittees() async {
    // Map<String, dynamic> com1 = {
    //   "name": "Tech committee",
    // };
    // Map<String, dynamic> com2 = {
    //   "name": "Logistics committee",
    // };
    // return [com1, com2, com1];
    // final temp =
    // return temp;
  }

  getComms() async {
    await userService.getCommittees().then((value) => comms = value);
    notifyListeners();
  }

  navigateToCommittee(String name) {}
}
