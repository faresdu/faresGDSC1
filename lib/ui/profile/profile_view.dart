import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(title: Text('File modified by fares')),
          );
        });
  }
}
