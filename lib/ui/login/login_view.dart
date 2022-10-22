import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/form_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked/stacked.dart';

import 'login_viewmodel.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
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
                      TextFormField(
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'الإيميل الجامعي أو الرقم الجامعي',
                          hintStyle: TextStyle(
                            fontFamily: GoogleFonts.mada().fontFamily,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
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
                      TextFormField(
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                        obscureText: true,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'كلمة المرور',
                          hintStyle: TextStyle(
                            fontFamily: GoogleFonts.mada().fontFamily,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                        ),
                        validator: FormValidators.passwordValidator,
                        onSaved: (value) {
                          viewmodel.password = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment(-1, 0),
                        child: Text('نسيت كلمة المرور',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(height: 100),
                      Container(
                        width: double.infinity,
                        height: 45,
                        margin: const EdgeInsets.symmetric(horizontal: 90),
                        child: ElevatedButton(
                          onPressed: () {
                            viewmodel.submitLogin(context);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF4081EC)),
                          child: const Text(
                            'سجل الدخول',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
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
