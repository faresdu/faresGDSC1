import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/core/utils/form_validators.dart';
import 'package:gdsc_app/ui/login/components/custom_input_field.dart';
import 'package:gdsc_app/ui/login/components/login_button.dart';
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
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: viewmodel.formKey,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      const SizedBox(height: 90),
                      Image.asset('assets/images/logo.png'),
                      const SizedBox(height: 65),

                      //Email Input Field
                      CustomInputField(
                        hintText: 'الإيميل الجامعي أو الرقم الجامعي',
                        validator: (value) {
                          //checking if its a valid student ID or email
                          if (FormValidators.studentIDValidator(value) != null && FormValidators.emailValidator(value) != null) {
                            // only if both have errors then input is incorrect
                            return FormValidators.studentIDValidator(value);
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
                      ),

                      const SizedBox(height: 20),

                      //Password Input Field
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
                      ),

                      const SizedBox(height: 20),

                      // Forgot password
                      Align(
                        alignment: const Alignment(-1, 0),
                        child: Text('نسيت كلمة المرور',
                            style: Constants.verySmallText.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Constants.darkBlue,
                            )),
                      ),
                      const SizedBox(height: 50),

                      //Login
                      LoginButton(
                        onPressed: () {
                          viewmodel.passwordFocus.unfocus();
                          viewmodel.submitLogin(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
