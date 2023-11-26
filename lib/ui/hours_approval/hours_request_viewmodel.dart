import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/hour_request.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/services/hour_service.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/models/committee.dart';

class HoursRequestViewModel extends BaseViewModel {
  final hourService = locator<HourService>();
  final navService = locator<NavigationService>();
  final userService = locator<SupabaseService>();
  List<HourRequest> upcomingRequests = [];
  List<HourRequest> previousRequests = [];
  List<Committee> committees = [];

  Future futureToRun() => getCommittees();

  getCommittees() async {
    await userService.getCommittees().then((value) => committees = value);
    notifyListeners();
  }

  void navigateToRequestsPage() {
    navService.navigateTo(Routes.hoursRequestView);
  }

  navigateToCommittee(Committee committee) async {
    setBusy(true);
    List<Member> members = await userService.getCommitteeMembers(committee.id);
    setBusy(false);
    navService.navigateTo(Routes.committeeMembersView,
        arguments: [members, committee]);
  }

  getUpcomingHourRequests() async {
    await hourService
        .getUpcomingHourRequests()
        .then((value) => upcomingRequests = value);
    upcomingRequests.sort((a, b) => b.createdAtMillis - a.createdAtMillis);
    notifyListeners();
  }

  void updateHourRequest(HourRequest request, bool status) async {
    try {
      print(request);
      await hourService.updateHourRequest(request.id, status);
      upcomingRequests.remove(request);
      request.approved = status;
      previousRequests.add(request);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getPreviousHourRequests() async {
    await hourService
        .getPreviousHourRequests()
        .then((value) => previousRequests = value);
    previousRequests.sort((a, b) => b.createdAtMillis - a.createdAtMillis);

    notifyListeners();
  }
}
