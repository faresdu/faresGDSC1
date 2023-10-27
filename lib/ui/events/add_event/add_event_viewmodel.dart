import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gdsc_app/core/enums/s3.dart';
import 'package:gdsc_app/core/services/s3_service.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../../core/app/app.locator.dart';
import '../../../core/models/event.dart';
import '../../../core/services/event_service.dart';
import '../../../core/services/user_service.dart';

class AddEventViewModel extends BaseViewModel {
  final eventService = locator<EventService>();
  final userService = locator<UserService>();
  final s3Service = locator<S3Service>();

  final formKey = GlobalKey<FormState>();

  String eventID = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController hostController = TextEditingController();
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  TextEditingController dateTimeController = TextEditingController();
  TextEditingController timeOfDayController = TextEditingController();

  bool isOnline = false;
  TextEditingController attendeesController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  XFile? image;
  Map<String, String>? uploadedImageUrl;
  bool uploaded = false;
  bool added = false;
  String? oldImage;

  @override
  void dispose() async {
    if (uploaded && added == false) {
      await s3Service.deleteFile(uploadedImageUrl!['filePath']!);
    }
    super.dispose();
  }

  Future<void> addEvent() async {
    setBusy(true);
    if (!_validate()) {
      setBusy(false);
      return;
    }
    if (dateTime != null && timeOfDay != null) {
      if (userService.user.isLeaderOrCoLeader()) {
        Event? e = makeEvent();
        if (e != null) {
          await eventService.addEvent(e);
          added = true;
        }
      }
    }
    setBusy(false);
  }

  bool _validate() {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    //Success
    formKey.currentState?.save();
    return true;
  }

  Future<void> editEvent() async {
    setBusy(true);
    if (dateTime != null && timeOfDay != null) {
      if (userService.user.isLeaderOrCoLeader()) {
        Event? e = makeEvent();
        if (e != null) {
          await eventService.editEvent(e);

          if (oldImage != null &&
              uploadedImageUrl != null &&
              oldImage!.contains(s3Service.bucketName)) {
            print("${S3FolderPaths.events}/${oldImage!.split("/").last}");
            await s3Service.deleteFile(
                "${S3FolderPaths.events}/${oldImage!.split("/").last}");
          }
          added = true;
        }
      }
    }
    setBusy(false);
  }

  Future<void> deleteEvent() async {
    await eventService.deleteEvent(eventID);
  }

  Event? makeEvent() {
    if (dateTime != null && timeOfDay != null) {
      DateTime d = DateHelper.DateTimeAndTimeOfDay(dateTime!, timeOfDay!);
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
          host: hostController.value.text.isNotEmpty
              ? hostController.value.text
              : null,
          flyer:
              uploadedImageUrl != null ? uploadedImageUrl!['url'] : oldImage);
    }
    return null;
  }

  void showImagePicker() async {
    setBusy(true);
    try {
      final ImagePicker picker = ImagePicker();
      XFile? temp = image;
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        image = temp;
        throw 'no image was picked';
      }
      if (uploadedImageUrl != null) {
        await s3Service.deleteFile(uploadedImageUrl!['filePath']!);
      }
      double fileSize = double.parse(
          await HelperFunctions.getFileSize(image!.path, 1, noSuffix: true));
      if (fileSize <= 6144) {
        uploadedImageUrl = await s3Service.uploadFile(File(image!.path),
            s3FolderPath: S3FolderPaths.events);
        uploaded = true;
      } else {
        image = null;
        //TODO: show image error message
      }
      print(await HelperFunctions.getFileSize(image!.path, 1));
    } catch (e) {
      print(e);
    }

    setBusy(false);
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
    hostController.text = event.host ?? "";
    dateTimeController.text =
        dateTime != null ? DateHelper.getDate(dateTime!) : '';
    timeOfDayController.text =
        timeOfDay != null ? DateHelper.getHourTOD(timeOfDay!) : '';
    oldImage = event.flyer;
    // image
    notifyListeners();
  }

  Future<bool?> confirmDeletionDialog(BuildContext context) async {
    return await HelperFunctions.warningDialog(context,
        title: 'حذف الفعالية', content: 'هل انت متاكد من حذف الفعالية؟');
  }
}
