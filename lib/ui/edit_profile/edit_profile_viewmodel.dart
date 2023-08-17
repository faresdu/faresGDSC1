import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/enums/s3.dart';
import 'package:gdsc_app/core/services/s3_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/member.dart';

class EditProfileViewmodel extends BaseViewModel {
  final userService = locator<UserService>();
  final s3Service = locator<S3Service>();

  late Member user;
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userCommitteController = TextEditingController();
  TextEditingController userHoursController = TextEditingController();
  XFile? image;
  Map<String, String>? uploadedImageUrl;
  bool uploaded = false;
  bool added = false;
  String? oldImage;
  late StreamSubscription listener;
  getUser() {
    user = userService.user;
    listener = userService.userSubject.listen((value) => user = value);
    userNameController.text = user.name;
    userCommitteController.text = user.committee.name;
    userHoursController.text = user.hours.toString();
    oldImage = user.photo;
  }

  @override
  void dispose() async {
    if (uploaded && added == false) {
      await s3Service.deleteFile(uploadedImageUrl!['filePath']!);
    }
    listener.cancel();
    super.dispose();
  }

  get isSaveDisabled {
    return userNameController.text == user.name && (!uploaded || added);
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
            s3FolderPath: S3FolderPaths.avatars);
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

  Future<void> editProfile() async {
    setBusy(true);
    if (!_validate()) {
      return;
    }
    if (oldImage != null &&
        uploadedImageUrl != null &&
        oldImage!.contains(s3Service.bucketName)) {
      print("${S3FolderPaths.avatars}/${oldImage!.split("/").last}");
      await s3Service
          .deleteFile("${S3FolderPaths.avatars}/${oldImage!.split("/").last}");
    }
    String? userPhoto =
        uploadedImageUrl != null ? uploadedImageUrl!['url'] : oldImage;
    try {
      await userService.updateUserInfo(
          name: userNameController.text, avatar: userPhoto);
      added = true;
      await userService.updateUser();
    } catch (e) {}
    setBusy(false);
    notifyListeners();
  }

  bool _validate() {
    if (!formKey.currentState!.validate()) {
      return false;
    }
    //Success
    formKey.currentState?.save();
    return true;
  }
}
