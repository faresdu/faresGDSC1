import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../../core/app/app.locator.dart';
import '../../../core/models/event.dart';
import '../../../core/services/event_service.dart';
import '../../../core/services/user_service.dart';

class AddEventViewModel extends BaseViewModel {
  final eventService = locator<EventService>();
  final userService = locator<UserService>();

  String eventID = '';
  TextEditingController titleController = TextEditingController();
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  bool isOnline = false;
  TextEditingController attendeesController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  XFile? image;

  Future<void> addEvent() async {
    if (dateTime != null && timeOfDay != null) {
      if (userService.user.isLeaderOrCoLeader()) {
        Event? E = makeEvent();
        if (E != null) {
          await eventService.addEvent(E);
        }
      }
    }
  }

  Future<void> editEvent() async {
    if (dateTime != null && timeOfDay != null) {
      if (userService.user.isLeaderOrCoLeader()) {
        Event? E = makeEvent();
        if (E != null) {
          await eventService.editEvent(E);
        }
      }
    }
  }

  Future<void> deleteEvent() async {
    await eventService.deleteEvent(eventID);
  }

  Event? makeEvent() {
    if (dateTime != null && timeOfDay != null) {
      DateTime d = DateHelper.DateTimeAndTimeOfDay(dateTime!, timeOfDay!);
      print(titleController.value.text);
      print(d);
      print(isOnline);
      print(attendeesController.value.text);
      print(locationController.value.text);
      print(descriptionController.value.text);
      print(image?.path);
      return Event(
        eventID: eventID,
        instructorID: userService.user.id,
        instructorName: userService.user.name,
        title: titleController.value.text,
        startDate: d,
        attendees: [],
        maxAttendees: int.parse(attendeesController.value.text),
        location: locationController.value.text,
        isOnline: isOnline,
        description: descriptionController.value.text,
      );
    }
    return null;
  }

  void showImagePicker() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

  setEventDetails(Event event) {
    eventID = event.eventID;
    titleController.text = event.title;
    dateTime = event.startDate;
    timeOfDay = TimeOfDay.fromDateTime(event.startDate);
    isOnline = event.isOnline;
    attendeesController.text = event.maxAttendees.toString();
    locationController.text = event.location;
    descriptionController.text = event.description ?? "";
    // image
    notifyListeners();
  }
}
