import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/services/supabase_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/services/authentication_service.dart';

class LoginViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();
  final authService = locator<AuthenticationService>();

  //Form data
  String? email;
  String? password;
  bool isNumber = false;

  final formKey = GlobalKey<FormState>();

  loginAndNavigate(context) async {
    try {
      await authService.loginWithEmail(email: email!, password: password!);
      navService.clearStackAndShow(Routes.navigationView);
    } catch (e) {
      //TODO SHOW ERROR PopUp Window
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'تاكد من صحة المعلومات',
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }

  submitLogin(context) {
    if (!formKey.currentState!.validate()) {
      print('Login Failed : invalid login information');
      return;
    }
    //Success
    formKey.currentState?.save();

    loginAndNavigate(context);
  }
}
