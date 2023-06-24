import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/leaderboard/leaderboard_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_buttom.dart';
import 'package:stacked/stacked.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LeaderboardViewModel>.reactive(
        viewModelBuilder: () => LeaderboardViewModel(),
        onModelReady: (model) => model.getLeaderboard(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(centerTitle: true, title: const Text('قائمة المتصدرين'), automaticallyImplyLeading: false),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: CustomButton(
                          onPressed: () {
                            viewmodel.navigateToHierarchy();
                          },
                          text: 'الهيكلة',
                          color: Constants.primaryLightBlue),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: viewmodel.members
                      .map((e) => Row(
                            children: [Text(e.name), Text(e.hours.toString())],
                          ))
                      .toList(),
                )
              ],
            ),
          );
        });
  }
}
