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
                                            style: Constants.smallText.copyWith(
                                                fontWeight: FontWeight.w900)),
                                        Text(viewmodel.user.committee.name,
                                            style: Constants.extraSmallText
                                                .copyWith(
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
