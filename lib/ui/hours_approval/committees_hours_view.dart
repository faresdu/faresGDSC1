import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/hours_approval/hours_request_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/hierarchy_button.dart';
import 'package:stacked/stacked.dart';

class CommitteesHoursView extends StatelessWidget {
  const CommitteesHoursView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HoursRequestViewModel>.reactive(
        viewModelBuilder: () => HoursRequestViewModel(),
        onViewModelReady: (viewModel) => viewModel.getRelatedCommittees(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: 'طلبات ساعات اللجان',
            ),
            backgroundColor: Constants.isDarkMode(context)
                ? Constants.background(context)
                : Constants.grayBackGround(context),
            body: SafeArea(
              child: BusyOverlay(
                isBusy: viewmodel.isBusy,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: viewmodel.committees
                        .map((c) => HierarchyButton(
                            onPressed: () {
                              viewmodel.navigateToCommitteeMembersHours(c);
                            },
                            committee: c))
                        .toList(),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
