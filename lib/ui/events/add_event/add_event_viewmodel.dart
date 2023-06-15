import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../../core/app/app.locator.dart';
import '../../../core/models/event.dart';
import '../../../core/models/member.dart';
import '../../../core/services/event_service.dart';
import '../../../core/services/user_service.dart';

class AddEventViewModel extends BaseViewModel {
  final eventService = locator<EventService>();
  final userService = locator<UserService>();

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
      DateTime d = DateHelper.DateTimeAndTimeOfDay(dateTime!, timeOfDay!);
      if (userService.user.isLeaderOrCoLeader()) {
        Member member = userService.user;
        await eventService.addEvent(Event(
          eventID: '',
          instructorID: member.id,
          instructorName: member.name,
          title: titleController.value.text,
          startDate: d,
          attendees: [],
          maxAttendees: int.parse(attendeesController.value.text),
          location: locationController.value.text,
          isOnline: isOnline,
          description: descriptionController.value.text,
        ));
      }
      print(titleController.value.text);
      print(d);
      print(isOnline);
      print(attendeesController.value.text);
      print(locationController.value.text);
      print(descriptionController.value.text);
      print(image?.path);
    }
  }

  void showImagePicker() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    notifyListeners();
  }

}