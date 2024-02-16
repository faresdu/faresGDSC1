import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/volunteer_hours.dart';
import 'package:gdsc_app/core/utils/form_validators.dart';
import 'package:gdsc_app/core/utils/string_extensions.dart';
import 'package:gdsc_app/ui/profile/profile_user_hours/profile_request_hours_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_text_form_field.dart';
import 'package:gdsc_app/ui/widgets/submit_button.dart';
import 'package:stacked/stacked.dart';

import '../../../core/utils/constants.dart';

class ProfileRequestHoursView extends StatefulWidget {
  const ProfileRequestHoursView({this.onSubmit, Key? key}) : super(key: key);
  final void Function(VolunteerHours volunteerHours)? onSubmit;

  @override
  State<ProfileRequestHoursView> createState() =>
      _ProfileRequestHoursViewState();
}

class _ProfileRequestHoursViewState extends State<ProfileRequestHoursView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileRequestHoursViewModel>.reactive(
        viewModelBuilder: () => ProfileRequestHoursViewModel(),
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
                    child: Form(
                      key: viewmodel.formKey,
                      child: Column(
                        children: [
                          Text(
                            'طلب ساعات',
                            style: Constants.mediumText.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          CustomTextFormField(
                            title: 'المهمة',
                            controller: viewmodel.reasonController,
                            validator: (value) =>
                                FormValidators.maxCharsValidator(value, 35),
                            onSaved: (value) => viewmodel.reason = value,
                            maxLines: 1,
                          ),
                          CustomTextFormField(
                            title: 'كمية الساعات',
                            controller: viewmodel.hourAmountController,
                            validator: FormValidators.hoursValidator,
                            onSaved: (value) =>
                                viewmodel.hours = value!.parseInt,
                            type: const TextInputType.numberWithOptions(),
                            maxLines: 1,
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 50),
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.1),
                              child: SubmitButton(
                                  text: 'رفع الطلب',
                                  isBusy: viewmodel.isBusy,
                                  onPressed: () async {
                                    viewmodel.setBusy(true);
                                    VolunteerHours? vol =
                                        await viewmodel.submit(context);
                                    if (vol != null) {
                                      if (widget.onSubmit != null) {
                                        widget.onSubmit!(vol);
                                      }
                                      Navigator.of(context).pop();
                                    }
                                    viewmodel.setBusy(false);
                                  }))
                        ],
                      ),
                    ),
                  ),
                ))
              ],
            ),
          );
        });
  }
}
