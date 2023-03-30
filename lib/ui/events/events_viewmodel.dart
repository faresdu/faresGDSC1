import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/app/app.router.dart';
import '../../core/models/member.dart';
import '../../core/services/supabase_service.dart';

class EventsViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();
  final userService = locator<SupabaseService>();
  List<Event> events = [];
  Event eventDetails = Event.placeholder();

  getEvents() async {
    await userService.getEvents().then((value) => events = value);
    notifyListeners();
  }

  getEvent(BuildContext context) {
    eventDetails = ModalRoute.of(context)!.settings.arguments! as Event;
  }

  navigateToEvent(Event event) async {
    // Event event = await userService.getEvent(id);
    // print(members.toString());
    navService.navigateTo(Routes.eventsDetailsView, arguments: event);
  }
}
