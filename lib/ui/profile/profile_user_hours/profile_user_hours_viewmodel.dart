import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/models/volunteer_hours.dart';
import 'package:gdsc_app/core/services/hour_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:stacked/stacked.dart';

class ProfileUserHoursViewModel extends BaseViewModel {
  final userService = locator<UserService>();
  final hourService = locator<HourService>();
  late Member user;
  final formKey = GlobalKey<FormState>();
  TextEditingController reasonController = TextEditingController();
  TextEditingController hourAmountController = TextEditingController();
  String? reason;
  int? hours;
  List<VolunteerHours> approvedUserHours = [];
  List<VolunteerHours> pendingUserHours = [];
  ProfileUserHoursViewModel() {
    user = userService.user;
    approvedUserHours = user.getApprovedVolunteerHours();
    pendingUserHours = user.getPendingVolunteerHours();
  }
  submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    //Success
    formKey.currentState?.save();
    setBusy(true);
    VolunteerHours pendingRequest =
        await hourService.sendHourRequest(reason!, hours!);
    print(pendingRequest);
    pendingUserHours.add(pendingRequest);
    notifyListeners();
    setBusy(false);
  }

  removeHourRequest(VolunteerHours request) async {
    setBusy(true);
    try {
      pendingUserHours.remove(request);
      await hourService.removeHourRequest(request.volunteerID);
    } catch (e) {
      print(e.toString());
      pendingUserHours.add(request);
    }
    setBusy(false);

    notifyListeners();
  }
}
