import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/core/utils/form_validators.dart';
import 'package:gdsc_app/ui/login/components/custom_input_field.dart';
import 'package:gdsc_app/ui/login/components/login_button.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
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
                            const SizedBox(height: 65),
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
                              child: Text('نسيت كلمة المرور',
                                  style: Constants.verySmallText.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: Constants.darkBlue,
                                  )),
                            ),
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
}
