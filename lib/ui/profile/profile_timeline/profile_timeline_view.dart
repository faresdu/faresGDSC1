import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/profile/profile_timeline/profile_timeline_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:stacked/stacked.dart';

class ProfileTimelineView extends StatelessWidget {
  const ProfileTimelineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileTimelineViewModel>.reactive(
        viewModelBuilder: () => ProfileTimelineViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: 'المنشورات',
            ),
            body: Column(
              children: [],
            ),
          );
        });
  }
}
