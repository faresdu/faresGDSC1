import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/widgets/member_card.dart';
import 'package:stacked/stacked.dart';

import 'committee_members_viewmodel.dart';

class CommitteeMembersView extends StatelessWidget {
  const CommitteeMembersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommitteeMembersViewModel>.reactive(
        viewModelBuilder: () => CommitteeMembersViewModel(),
        onModelReady: (model) => model.setMembers(context),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(title: Text(viewmodel.committee.name)),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (viewmodel.leader != null)
                  MemberCard(
                      onPressed: () {},
                      member: viewmodel.leader!,
                      role: 'قائد'),
                if (viewmodel.coLeader != null)
                  MemberCard(
                    onPressed: () {},
                    member: viewmodel.coLeader!,
                    role: 'نائب القائد',
                  ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: viewmodel.members
                      .map((e) => MemberCard(onPressed: () {}, member: e))
                      .toList(),
                )
              ],
            ),
          );
        });
  }
}
