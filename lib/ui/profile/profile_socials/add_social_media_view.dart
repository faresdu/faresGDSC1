import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/user_social_media.dart';
import 'package:gdsc_app/core/utils/form_validators.dart';
import 'package:gdsc_app/ui/profile/components/socials_drop_down_menu.dart';
import 'package:gdsc_app/ui/profile/profile_socials/add_social_media_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_text_form_field.dart';
import 'package:gdsc_app/ui/widgets/submit_button.dart';
import 'package:stacked/stacked.dart';

class AddSocialMediaView extends StatefulWidget {
  const AddSocialMediaView({this.onSubmit, super.key});
  final void Function(UserSocialMedia userSocialMedia)? onSubmit;

  @override
  State<AddSocialMediaView> createState() => _AddSocialMediaViewState();
}

class _AddSocialMediaViewState extends State<AddSocialMediaView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddSocialMediaViewModel>.reactive(
        viewModelBuilder: () => AddSocialMediaViewModel(),
        builder: (context, viewmodel, _) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 13, bottom: 8),
                  height: 4,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const Text(
                          'اضافه منصة تواصل',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Form(
                          key: viewmodel.formKey,
                          child: Column(children: [
                            SocialsDropDownMenu(
                              title: 'اختر نوع منصة التواصل',
                              socialMedias: viewmodel.socialMedias,
                              onChanged: (String? value) {
                                setState(() {
                                  viewmodel.selectedSocialId = value;
                                });
                              },
                            ),
                            CustomTextFormField(
                              title: 'اسم المستخدم',
                              controller: viewmodel.userNameController,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'الرجاء ادخال اسم المستخدم';
                                }
                                return null;
                              },
                              onSaved: (val) => viewmodel.userName = val,
                            ),
                            CustomTextFormField(
                              title: 'الرابط',
                              controller: viewmodel.linkController,
                              validator: FormValidators.linkValidator,
                              onSaved: (val) => viewmodel.link = val,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 100),
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.1),
                              child: SubmitButton(
                                  text: 'إضـافـة',
                                  onPressed: () async {
                                    viewmodel.setBusy(true);
                                    UserSocialMedia? social =
                                        await viewmodel.addSocialMedia(context);
                                    if (widget.onSubmit != null &&
                                        social != null) {
                                      widget.onSubmit!(social);
                                      Navigator.pop(context);
                                    }
                                    viewmodel.setBusy(false);
                                  }),
                            )
                          ]),
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
          );
        });
  }
}
