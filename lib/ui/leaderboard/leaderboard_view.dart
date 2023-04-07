import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/leaderboard/leaderboard_viewmodel.dart';
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
            appBar: AppBar(
                centerTitle: true,
                title: const Text('قائمة المتصدرين'),
                automaticallyImplyLeading: false),
            body: Column(
              children: [
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
