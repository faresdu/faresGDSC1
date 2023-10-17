import 'package:gdsc_app/core/models/hour_request.dart';
import 'package:gdsc_app/core/services/hour_service.dart';
import 'package:stacked/stacked.dart';

import '../../core/app/app.locator.dart';

class HoursRequestViewModel extends BaseViewModel {
  final hourService = locator<HourService>();
  List<HourRequest> upcomingRequests = [];
  List<HourRequest> previousRequests = [];

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
