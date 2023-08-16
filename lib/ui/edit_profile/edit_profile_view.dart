import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/edit_profile/components/Savebutton.dart';
import 'package:gdsc_app/ui/notifications/addNotifitcaion_view.dart';
import 'package:gdsc_app/ui/widgets/custom_text_form_field.dart';
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
                          backgroundImage: NetworkImage(
                              viewmodel.userService.user.photo ?? ""),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Form(
                        key: viewmodel.formKey,
                        child: Column(
                          children: [
                            Container(
                              child: CustomTextFormField(
                                controller: viewmodel.userNameController,
                                title: "الاسم",
                                shadow: Constants.inputShadow,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: CustomTextFormField(
                                  controller: viewmodel.userCommitteController,
                                  title: "اللجنة",
                                  shadow: Constants.inputShadow),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: CustomTextFormField(
                                controller: viewmodel.userHoursController,
                                title: "الساعات",
                                shadow: Constants.inputShadow,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 20),
                              child: SaveButton(
                                  color: Colors.blue,
                                  text: "حفظ",
                                  fontSize: 16,
                                  onPressed: () {}),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
