import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/hour_request.dart';
import 'package:gdsc_app/core/services/hour_service.dart';

import 'package:gdsc_app/core/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/models/committee.dart';
import '../../core/services/supabase_service.dart';

class HoursRequestViewModel extends BaseViewModel {
  final hourService = locator<HourService>();
  final navService = locator<NavigationService>();
  final userService = locator<UserService>();
  final appService = locator<SupabaseService>();
  List<HourRequest> upcomingRequests = [];
  List<HourRequest> previousRequests = [];
  List<Committee> committees = [];
  late Committee currentCommittee;

  getRelatedCommittees() async {
    setBusy(true);
    await appService.getCommittees().then((value) => committees = value);
    if (userService.user.isAdmin || userService.user.isHrAdmin()) {
    } else if (userService.user.isLeader() || userService.user.isCoLeader()) {
      committees.removeWhere(
          (committee) => committee.id != userService.user.committee.id);
    } else {
      committees.removeWhere(
          (committee) => committee.responsibleCommittee != userService.user.id);
    }
    setBusy(false);
    notifyListeners();
  }

  assignCommittee(BuildContext context) {
    currentCommittee =
        (ModalRoute.of(context)!.settings.arguments as List<Committee>)[0];

    notifyListeners();
  }

  getUpcomingHourRequests(BuildContext context) async {
    assignCommittee(context);
    try {
      await hourService
          .getUpcomingHourRequests(currentCommittee.id)
          .then((value) => upcomingRequests = value.toList());
    } catch (e) {
      print(e);
    }

    upcomingRequests.sort((a, b) => b.createdAtMillis - a.createdAtMillis);
    notifyListeners();
  }

  void updateHourRequest(HourRequest request, bool status) async {
    try {
      await hourService.updateHourRequest(request.id, status);
      upcomingRequests.remove(request);
      request.approved = status;
      previousRequests.add(request);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  getPreviousHourRequests(BuildContext context) async {
    assignCommittee(context);

    try {
      await hourService
          .getPreviousHourRequests(currentCommittee.id)
          .then((value) => previousRequests = value.toList());
    } catch (e) {
      print(e);
    }

    previousRequests.sort((a, b) => b.createdAtMillis - a.createdAtMillis);

    notifyListeners();
  }

  navigateToCommitteeMembersHours(Committee committee) async {
    navService.navigateTo(Routes.hoursRequestView, arguments: [committee]);
  }
}
