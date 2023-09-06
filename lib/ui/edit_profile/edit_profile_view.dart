import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import 'package:gdsc_app/ui/edit_profile/components/Savebutton.dart';
import 'package:gdsc_app/ui/profile/profile_user_hours/profile_request_hours_view.dart';
import 'package:gdsc_app/ui/widgets/custom_bottom_modal_sheet.dart';
import 'package:gdsc_app/ui/widgets/custom_text_form_field.dart';
import 'package:gdsc_app/ui/widgets/submit_button.dart';
import 'package:stacked/stacked.dart';
import '../../core/utils/constants.dart';
import '../widgets/custom_app_bar.dart';
import 'edit_profile_viewmodel.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewmodel>.reactive(
        viewModelBuilder: () => EditProfileViewmodel(),
        onViewModelReady: (viewmodel) => viewmodel.getUser(),
        builder: (context, viewmodel, _) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              backgroundColor: Constants.background,
              appBar: const CustomAppBar(
                title: "تعديل الملف الشخصي",
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => viewmodel.showImagePicker(),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 65,
                                backgroundImage: viewmodel.image != null
                                    ? Image.file(File(viewmodel.image!.path))
                                        .image
                                    : HelperFunctions.avatarImageProvider(
                                        imageUrl:
                                            viewmodel.userService.user.photo ??
                                                ""),
                              ),
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: Icon(Icons.edit, size: 25),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Form(
                            key: viewmodel.formKey,
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  controller: viewmodel.userNameController,
                                  validator: FormBuilderValidators.required(
                                      errorText: "الرجاء ادخال الاسم"),
                                  title: "الاسم",
                                  shadow: Constants.inputShadow,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: CustomTextFormField(
                                            controller: viewmodel
                                                .userCommitteController,
                                            style: Constants.smallText.copyWith(
                                                color: Constants.lightGrey),
                                            title: "اللجنة",
                                            enableInteractiveSelection: false,
                                            onTap: () {},
                                            shadow: Constants.inputShadow),
                                      ),
                                      SubmitButton(
                                        text: "رفع\nطلب",
                                        onPressed: () {},
                                        disabled: true,
                                        style: Constants.verySmallText.copyWith(
                                          height: 1.23,
                                        ),
                                        width: 55,
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: CustomTextFormField(
                                          title: "الساعات",
                                          style: Constants.smallText.copyWith(
                                              color: Constants.lightGrey),
                                          controller:
                                              viewmodel.userHoursController,
                                          enableInteractiveSelection: false,
                                          onTap: () {},
                                          shadow: Constants.inputShadow,
                                        ),
                                      ),
                                      SubmitButton(
                                        text: "رفع\nطلب",
                                        onPressed: () {
                                          CustomModalBottomSheet(context,
                                              const ProfileRequestHoursView());
                                        },
                                        style: Constants.verySmallText.copyWith(
                                          height: 1.23,
                                        ),
                                        width: 55,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, top: 16),
                                  child: SaveButton(
                                      color: Colors.blue,
                                      text: "حفظ",
                                      fontSize: 16,
                                      isLoading: viewmodel.isBusy,
                                      disabled: viewmodel.isSaveDisabled,
                                      onPressed: () => viewmodel.editProfile()),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
