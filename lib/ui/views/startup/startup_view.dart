import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/views//startup/startup_viewmodel%20.dart';
import 'package:gdsc_app/ui/views/startup/bb.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
        viewModelBuilder: () => StartUpViewModel(),
        onModelReady: (viewModel) => viewModel.checkUser(),
        builder: (context, viewModel, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text('GDSC Startup'),
              centerTitle: true,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      CustomButton(
                        onPressed: viewModel.navigateToLogin,
                        text: 'StartUp',
                      ),
                    ]),
                  ],
                )
              ],
            ),
          );
        });
  }
}
