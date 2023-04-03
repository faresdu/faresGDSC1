import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/form_validators.dart';
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
                      TextFormField(
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'الإيميل الجامعي أو الرقم الجامعي',
                          hintStyle: TextStyle(
                            fontFamily: GoogleFonts.mada().fontFamily,
                            color: Color(0xFF666C74),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),

                          enabledBorder:  OutlineInputBorder(
                              borderSide: BorderSide(width:3, color:Color(0xFF212A40) ),
                              borderRadius: BorderRadius.circular(50),
                        ),
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
                            color:Color(0xFF666C74),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          enabledBorder:  OutlineInputBorder(
                              borderSide: BorderSide(width: 3, color: Color(0xFF212A40)),
                              borderRadius: BorderRadius.circular(50),
                        ),
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
                                fontSize: 15, fontWeight: FontWeight.w700,color:const Color(0xFF212A40), )),
                      ),
                      const SizedBox(height: 50),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 80),
                        child: ElevatedButton(
                          onPressed: () {
                            viewmodel.submitLogin(context);
                          },

                          style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF212A40),
                              shape: StadiumBorder(),),

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
