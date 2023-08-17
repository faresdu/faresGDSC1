import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/leaderboard_member.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import 'package:gdsc_app/ui/leaderboard/components/leaderboard_item.dart';
import 'package:gdsc_app/ui/leaderboard/components/top3.dart';
import 'package:gdsc_app/ui/leaderboard/leaderboard_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/custom_buttom.dart';
import 'package:gdsc_app/ui/widgets/submit_button.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/member.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LeaderboardViewModel>.reactive(
      viewModelBuilder: () => LeaderboardViewModel(),
      onViewModelReady: (model) => model.getLeaderboard(),
      builder: (context, viewmodel, _) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "المتصدرين",
            actions: [
              SizedBox(
                width: 100,
                child: SubmitButton(
                  outlined: true,
                  onPressed: () {
                    viewmodel.navigateToHierarchy();
                  },
                  style: Constants.smallText,
                  text: 'الهيكلة',
                ),
              ),
            ],
            leading: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                "./assets/images/BarLogo.png",
              ),
            ),
            leadingWidth: 100,
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              if (viewmodel.top3Members.length >= 3)
                Top3(
                  members: viewmodel.top3Members,
                  navigateToProfile: viewmodel.navigateToUserProfile,
                ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    boxShadow: Constants.shadow4,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: viewmodel.members.length,
                    itemBuilder: (context, index) {
                      return LeaderboardItem(
                        member: viewmodel.members[index],
                        index: index,
                        navigateToProfile: viewmodel.navigateToUserProfile,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
