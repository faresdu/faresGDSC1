import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/hour_request.dart';
import 'package:gdsc_app/core/models/semester.dart';
import 'package:gdsc_app/core/services/hour_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/models/committee.dart';
import '../../core/services/semester_service.dart';
import '../../core/services/supabase_service.dart';

class HoursRequestViewModel extends BaseViewModel {
  final hourService = locator<HourService>();
  final navService = locator<NavigationService>();
  final userService = locator<UserService>();
  final appService = locator<SupabaseService>();
  final semesterService = locator<SemesterService>();
  List<HourRequest> upcomingRequests = [];
  List<HourRequest> previousRequests = [];
  List<Committee> committees = [];
  late Committee currentCommittee;
  late Semester currentSemesterWeek;

  List<int> semesterWeeks = [];
  List<int> selectedSemesterWeeksList = [];

  HoursRequestViewModel();

  factory HoursRequestViewModel.init(BuildContext context) {
    final vm = HoursRequestViewModel();
    vm.assignCommittee(context);
    return vm;
  }

  void init(BuildContext context) async {
    setBusy(true);
    await semesterService
        .getCurrentSemester()
        .then((value) => currentSemesterWeek = value);
    var currentWeek = await semesterService.getWeek(DateTime.now());
    semesterWeeks = [];
    for (var i = 1; i <= currentWeek; i++) {
      semesterWeeks.add(i);
    }
    await Future.wait([getUpcomingHourRequests(), getPreviousHourRequests()]);
    setBusy(false);
    notifyListeners();
  }

  get getUpcomingRequests {
    return selectedSemesterWeeksList.isEmpty
        ? upcomingRequests
        : upcomingRequests
            .where(
                (req) => selectedSemesterWeeksList.contains(req.semesterWeek))
            .toList();
  }

  get getPreviousRequests {
    return selectedSemesterWeeksList.isEmpty
        ? previousRequests
        : previousRequests
            .where(
                (req) => selectedSemesterWeeksList.contains(req.semesterWeek))
            .toList();
  }

  get selectedWeeksText {
    if (selectedSemesterWeeksList.length == semesterWeeks.length) {
      return "جميع الاسابيع";
    } else {
      return "عدد الاسابيع المحدده: ${selectedSemesterWeeksList.length}";
    }
  }

  onApproveOrReject(HourRequest request, bool status) {
    updateHourRequest(request, status);
  }

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

  Future<void> getUpcomingHourRequests() async {
    try {
      await hourService
          .getUpcomingHourRequests(currentCommittee.id)
          .then((value) => upcomingRequests = value.toList());
    } catch (e) {
      print(e);
    }

    upcomingRequests.sort((a, b) => b.createdAtMillis - a.createdAtMillis);

    await _getWeek();
    notifyListeners();
  }

  Future<void> _getWeek({bool upcoming = true}) async {
    if (upcoming) {
      for (var i = 0; i < upcomingRequests.length; i++) {
        upcomingRequests[i].semesterWeek = await semesterService.getWeek(
            DateTime.fromMillisecondsSinceEpoch(
                upcomingRequests[i].createdAtMillis));
      }
    } else {
      for (var i = 0; i < previousRequests.length; i++) {
        previousRequests[i].semesterWeek = await semesterService.getWeek(
            DateTime.fromMillisecondsSinceEpoch(
                previousRequests[i].createdAtMillis));
      }
    }
  }

  Future<void> updateHourRequest(HourRequest request, bool status,
      {bool isPrevious = false}) async {
    try {
      setBusy(true);
      await hourService.updateHourRequest(request.id, status);
      if (isPrevious) {
        request.approved = status;
      } else {
        upcomingRequests.remove(request);
        request.approved = status;
        previousRequests.add(request);
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
    setBusy(false);
  }

  Future<void> getPreviousHourRequests() async {
    try {
      await hourService
          .getPreviousHourRequests(currentCommittee.id)
          .then((value) => previousRequests = value.toList());
    } catch (e) {
      print(e);
    }

    previousRequests.sort((a, b) => b.createdAtMillis - a.createdAtMillis);

    await _getWeek(upcoming: false);
    await _getWeek(upcoming: false);
    notifyListeners();
  }

  navigateToCommitteeMembersHours(Committee committee) async {
    navService.navigateTo(Routes.hoursRequestView, arguments: [committee]);
  }

  Future<void> openFilterDialog(BuildContext context) async {
    await FilterListDialog.display<int>(
      context,
      hideSearchField: true,
      hideSelectedTextCount: true,
      backgroundColor: Constants.background,
      headlineText: "اختر الاسابيع",
      resetButtonText: "إعادة ضبط",
      applyButtonText: "تطبيق",
      allButtonText: "الكل",
      listData: semesterWeeks,
      choiceChipLabel: (week) => "اسبوع $week",
      validateSelectedItem: (list, val) => list!.contains(val),
      selectedListData: selectedSemesterWeeksList,
      onApplyButtonClick: (list) {
        selectedSemesterWeeksList = List.from(list!);
        Navigator.pop(context);
        notifyListeners();
      },
      onItemSearch: (item, String query) {
        return item.toString().contains(query);
      },
    );
    // Navigator.pop(context);
  }
}
