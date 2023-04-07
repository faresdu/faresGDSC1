import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/core/utils/form_validators.dart';
import 'package:gdsc_app/ui/login/components/custom_input_field.dart';
import 'package:gdsc_app/ui/login/components/login_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
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
                          //check if the value is correct studentID
                          //if not check if its a valid email
                          if (FormValidators.studentIDValidator(
                                  value, viewmodel) !=
                              null) {
                            //checking if its a valid email
                            return FormValidators.emailValidator(value);
                          } else {
                            //the value is studentID
                            return null;
                          }
                        },
                        onSaved: (value) {
                          if (viewmodel.isNumber) {
                            viewmodel.email = '$value@student.ksu.edu.sa';
                          } else {
                            viewmodel.email = value;
                          }
                        },
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
                      ),

                      const SizedBox(height: 20),

                      // Forgot password
                      Align(
                        alignment: Alignment(-1, 0),
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
