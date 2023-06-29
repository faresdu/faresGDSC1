import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/profile/profile_user_hours/profile_user_hours_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfileUserHoursView extends StatelessWidget {
  const ProfileUserHoursView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileUserHoursViewModel>.reactive(
        viewModelBuilder: () => ProfileUserHoursViewModel(),
        builder: (context, viewmodel, _) {
          return Container();
        });
  }
}
