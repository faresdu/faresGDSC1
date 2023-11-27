import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/hour_request.dart';
import 'package:gdsc_app/core/services/hour_service.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/models/committee.dart';

class HoursRequestViewModel extends BaseViewModel {
  final hourService = locator<HourService>();
  final navService = locator<NavigationService>();
  final userService = locator<UserService>();
  final appService = locator<SupabaseService>();
  List<HourRequest> upcomingRequests = [];
  List<HourRequest> previousRequests = [];
  List<Committee> committees = [];
  var currentCommittee;

  getRelatedCommittees() async {
    await appService.getCommittees().then((value) => committees = value);
    if (userService.user.isAdmin || userService.user.isHrAdmin()) {
      // simply it will DO NOTHING and return all committees
    } else if (userService.user.isLeader() || userService.user.isCoLeader()) {
      // will return the committee for only the leader or co-leader
      committees.removeWhere(
          (committee) => committee.id != userService.user.committee.id);
    } else {
      // will return the committees for only the hr mebmbers reposnsible for
      committees.removeWhere(
          (committee) => committee.responsibleCommittee != userService.user.id);
    }
    notifyListeners();
  }

  void navigateToRequestsPage() {
    navService.navigateTo(Routes.hoursRequestView);
    print(currentCommittee.name);
    notifyListeners();
  }

  getUpcomingHourRequests() async {
    print(currentCommittee.id);
    await hourService
        .getUpcomingHourRequests()
        .then((value) => upcomingRequests = value);
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
