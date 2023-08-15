import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/member.dart';

class EditProfileViewmodel extends BaseViewModel {
  final userService = locator<UserService>();
  late Member user;
  final formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userCommitteController = TextEditingController();
  TextEditingController userHoursController = TextEditingController();

  getUser() {
    user = userService.user;
    userNameController.text = user.name;
    userCommitteController.text = user.committee.name;
    userHoursController.text = user.hours.toString();
  }

  // void showImagePicker() async {
  //   setBusy(true);
  //   try {
  //     final ImagePicker picker = ImagePicker();
  //     XFile? temp = image;
  //     image = await picker.pickImage(source: ImageSource.gallery);
  //     if (image == null) {
  //       image = temp;
  //       throw 'no image was picked';
  //     }
  //     if (uploadedImageUrl != null) {
  //       await s3Service.deleteFile(uploadedImageUrl!['filePath']!);
  //     }
  //     double fileSize = double.parse(
  //         await HelperFunctions.getFileSize(image!.path, 1, noSuffix: true));
  //     if (fileSize <= 6144) {
  //       uploadedImageUrl = await s3Service.uploadFile(File(image!.path),
  //           s3FolderPath: S3FolderPaths.events);
  //       uploaded = true;
  //     } else {
  //       image = null;
  //       //TODO: show image error message
  //     }
  //     print(await HelperFunctions.getFileSize(image!.path, 1));
  //   } catch (e) {
  //     print(e);
  //   }

  //   setBusy(false);
  //   notifyListeners();
  // }

  // listenToUser() {}
}
