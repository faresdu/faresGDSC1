import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/core/utils/form_validators.dart';
import 'package:gdsc_app/ui/login/components/custom_input_field.dart';
import 'package:gdsc_app/ui/login/components/login_button.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            body: SafeArea(
              child: BusyOverlay(
                isBusy: viewmodel.isBusy,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: viewmodel.formKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: AutofillGroup(
                        child: Column(
                          children: [
                            Image.asset('assets/images/GDSC/middle_logo.png'),
                            CustomInputField(
                              hintText: 'الإيميل أو الرقم الجامعي',
                              validator: (value) {
                                //checking if its a valid student ID or email
                                if (FormValidators.studentIDValidator(value) !=
                                        null &&
                                    FormValidators.emailValidator(value) !=
                                        null) {
                                  // only if both have errors then input is incorrect
                                  return FormValidators.studentIDValidator(
                                      value);
                                }
                                //the value is correct
                                return null;
                              },
                              onSaved: (value) {
                                viewmodel.fixEmail(value);
                              },
                              onFieldSubmitted: (value) {
                                viewmodel.passwordFocus.requestFocus();
                              },
                              focusNode: viewmodel.emailFocus,
                              autofillHints: const [AutofillHints.email],
                            ),
                            const SizedBox(height: 20),
                            CustomInputField(
                              hintText: 'كلمة المرور',
                              obscureText: true,
                              validator: FormValidators.passwordValidator,
                              onSaved: (value) {
                                viewmodel.password = value;
                              },
                              onFieldSubmitted: (value) {
                                viewmodel.submitLogin(context);
                              },
                              focusNode: viewmodel.passwordFocus,
                              autofillHints: const [AutofillHints.password],
                            ),
                            const SizedBox(height: 20),
                            Align(
                                alignment: const Alignment(-1, 0),
                                child: TextButton(
                                  onPressed: () {
                                    openDialog(
                                        context, viewmodel, viewmodel.isBusy);
                                  },
                                  child: Text(
                                    "استعادة كلمة المرور",
                                    style: Constants.verySmallText.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Constants.darkBlue,
                                    ),
                                  ),
                                )),
                            const SizedBox(height: 50),
                            LoginButton(
                              onPressed: () {
                                viewmodel.submitLogin(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future openDialog(BuildContext context, viewmodel, isBusy) async {
    final formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Constants.background,
        scrollable: true,
        content: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height * 0.16,
          child: Form(
            key: formKey,
            child: CustomTextFormField(
              controller: viewmodel.resetPasswordController,
              title: 'البريد الالكتروني',
              hintText: 'example@gmail.com',
              autofocus: true,
              validator: (value) => FormValidators.emailValidator(value,
                  message: 'الرجاء إدخال بريد الكتروني صحيح'),
              onSaved: (value) {
                viewmodel.resetPasswordController.text = value;
              },
            ),
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              autofocus: true,
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  bool success = await viewmodel.resetPasswordThroughEmail();

                  viewmodel.resetPasswordController.text = "";
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    success
                        ? SnackBar(
                            backgroundColor: Constants.green,
                            content: Text('تم إرسال طلب استعادة كلمة المرور',
                                textAlign: TextAlign.center,
                                style: Constants.mediumText
                                    .copyWith(color: Constants.white)),
                          )
                        : SnackBar(
                            backgroundColor: Constants.red,
                            content: Text('حاول مجددا',
                                textAlign: TextAlign.center,
                                style: Constants.mediumText
                                    .copyWith(color: Constants.white)),
                          ),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: Constants.blueButton,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: MediaQuery.of(context).size.width * 0.6,
                child: Center(
                  child: Text(
                    isBusy ? 'جاري الارسال' : 'ارسال',
                    style: TextStyle(color: Constants.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
