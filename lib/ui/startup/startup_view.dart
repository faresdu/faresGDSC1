import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/startup/startup_viewmodel%20.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';
import '../../core/app/app.router.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  State<StartUpView> createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  final navService = locator<NavigationService>();

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      navService.navigateTo(Routes.loginView);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () => StartUpViewModel(),
      builder: (context, viewmodel, _) {
        return const Scaffold(
          body: Center(child: Image(image: AssetImage('assets/images/logo.png'))),
        );
      },
    );
  }
}
