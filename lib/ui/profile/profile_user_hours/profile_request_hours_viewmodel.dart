import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/models/volunteer_hours.dart';
import 'package:gdsc_app/core/services/hour_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:stacked/stacked.dart';

class ProfileRequestHoursViewModel extends BaseViewModel {
  final userService = locator<UserService>();
  final hourService = locator<HourService>();

  final formKey = GlobalKey<FormState>();

  TextEditingController reasonController = TextEditingController();
  TextEditingController hourAmountController = TextEditingController();
  String? reason;
  int? hours;

  Future submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    //Success
    formKey.currentState?.save();
    setBusy(true);
    VolunteerHours pendingRequest =
        await hourService.sendHourRequest(reason!, hours!);
    print(pendingRequest);
    // pendingUserHours.add(pendingRequest);
    await userService.updateUser();
    notifyListeners();
    setBusy(false);
    return pendingRequest;
  }
}
