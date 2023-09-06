import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/startup/startup_viewmodel .dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/app/app.locator.dart';

class StartUpView extends StatelessWidget {
  StartUpView({super.key});
  final navService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      viewModelBuilder: () => StartUpViewModel(),
      onViewModelReady: (viewmodel) => viewmodel.checkUser(),
      builder: (context, viewmodel, _) {
        return const Scaffold(
          body: Center(
            child: Image(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
        );
      },
    );
  }
}
