import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/committee_members/components/committee_leader_card.dart';
import 'package:gdsc_app/ui/committee_members/components/committee_member_card.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:stacked/stacked.dart';

import 'committee_members_viewmodel.dart';

class CommitteeMembersView extends StatelessWidget {
  const CommitteeMembersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommitteeMembersViewModel>.reactive(
        viewModelBuilder: () => CommitteeMembersViewModel(),
        onViewModelReady: (model) => model.setMembers(context),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: CustomAppBar(title: viewmodel.committee.name),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (viewmodel.leader != null)
                        CommitteeLeaderCard(
                          member: viewmodel.leader!,
                          isCoLeader: false,
                          onTap: viewmodel.navigateToMemberProfile,
                        ),
                      if (viewmodel.coLeader != null)
                        CommitteeLeaderCard(
                          member: viewmodel.coLeader!,
                          isCoLeader: true,
                          onTap: viewmodel.navigateToMemberProfile,
                        ),
                      if (viewmodel.consultant != null)
                        CommitteeLeaderCard(
                          member: viewmodel.consultant!,
                          onTap: viewmodel.navigateToMemberProfile,
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (viewmodel.members.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            height: 49,
                            width: MediaQuery.of(context).size.width * 0.62,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              ),
                              color: Constants.infoLight,
                            ),
                            child: Center(
                              child: Text(
                                'الأعضاء',
                                style: Constants.veryLargeText.copyWith(
                                    color: Constants.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      Column(
                        children: viewmodel.members
                            .map((e) => CommitteeMemberCard(
                                  member: e,
                                  onTap: viewmodel.navigateToMemberProfile,
                                ))
                            .toList(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
