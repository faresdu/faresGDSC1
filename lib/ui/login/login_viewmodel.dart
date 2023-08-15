import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/services/event_service.dart';
import 'package:gdsc_app/core/utils/string_extensions.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/services/authentication_service.dart';

class LoginViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();
  final authService = locator<AuthenticationService>();
  final eventService = locator<EventService>();
  //Form data
  String? email;
  String? password;

  late final FocusNode emailFocus = FocusNode();
  late final FocusNode passwordFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  loginAndNavigate(context) async {
    try {
      await authService.loginWithEmail(email: email!, password: password!);
      eventService.listenToAllEvents();
      navService.clearStackAndShow(Routes.navigationView);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
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

  @override
  void dispose() {
    super.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
  }

  void fixEmail(String? value) {
    if (value == null) return;
    if (value.isNumber) {
      email = '$value@student.ksu.edu.sa';
    } else {
      print(email);
      email = value.trim();
    }
  }
}
