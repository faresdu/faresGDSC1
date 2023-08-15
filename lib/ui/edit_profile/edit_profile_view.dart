import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/ui/widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';

import '../../core/utils/constants.dart';
import '../profile/profile_viewmodel.dart';
import '../widgets/custom_app_bar.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        onViewModelReady: (viewModel) => viewModel.listenToUser(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            backgroundColor: Constants.background,
            appBar: CustomAppBar(
              title: "الملف الشخصي",
              leading: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  "./assets/images/BarLogo.png",
                ),
              ),
              leadingWidth: 100,
            ),
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage:
                              NetworkImage(viewmodel.user.photo ?? ""),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              viewmodel.showImagePicker();
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        children: [
                          Container(
                            child: CustomTextFormField(
                              controller: TextEditingController(),
                              title: "الاسم",
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: CustomTextFormField(
                              controller: TextEditingController(),
                              title: "اللجنة",
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: CustomTextFormField(
                              controller: TextEditingController(),
                              title: "الساعات",
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
