import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/form_validators.dart';
import 'package:gdsc_app/ui/notifications/notifications_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_text_form_field.dart';
import 'package:gdsc_app/ui/widgets/rounded_submit_button.dart';
import 'package:stacked/stacked.dart';

import '../../../core/utils/constants.dart';
import '../../core/utils/helper_functions.dart';

class AddNotification extends StatefulWidget {
  const AddNotification({super.key});

  @override
  State<AddNotification> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddNotification> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationsViewModel>.reactive(
        viewModelBuilder: () => NotificationsViewModel(),
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
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Form(
                        key: viewmodel.formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: ClipOval(
                                        child: HelperFunctions.profileImage(
                                            imageUrl:
                                                viewmodel.user.photo ?? '',
                                            gender: viewmodel.user.gender ?? "",
                                            height: 50,
                                            width: 50),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(viewmodel.user.name,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900)),
                                        Text(viewmodel.user.committee.name,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Constants.grey)),
                                      ],
                                    ),
                                  ],
                                ),
                                RoundedSubmitButton(
                                    text: "نشر",
                                    isBusy: viewmodel.isBusy,
                                    onPressed: () async {
                                      await viewmodel.addNotification(context);
                                    }),
                              ],
                            ),
                            CustomTextFormField(
                              title: '',
                              validator: (value) =>
                                  FormValidators.minCharsValidator(value, 5),
                              controller: viewmodel.descriptionController,
                              maxLines: 1,
                              maxLength: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

Widget _TextWithChild({required String title, required Widget child}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        child,
      ],
    ),
  );
}

Widget SubmitButton(
    {required Function() onPressed,
    required String text,
    required double sizeX,
    required double sizeY}) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      fixedSize: Size(sizeX, sizeY),
      backgroundColor: Constants.blueButton,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget CustomTextField(
    {required String title,
    required TextEditingController controller,
    autofocus = false,
    int maxLines = 1,
    Widget? icon,
    TextInputType? type}) {
  return _TextWithChild(
    title: title,
    child: TextField(
      maxLength: 125,
      maxLines: maxLines,
      autofocus: autofocus,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: icon,
          ),
          prefixIconConstraints: const BoxConstraints(maxWidth: 22 + 30),
          contentPadding: EdgeInsets.zero,
          fillColor: Colors.white,
          filled: true,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          )),
    ),
  );
}
