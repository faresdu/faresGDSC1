import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:stacked/stacked.dart';

import '../../core/models/committee.dart';

class CommitteeMembersViewModel extends BaseViewModel {
  Member? leader;
  Member? coLeader;
  late Committee committee;
  List<Member> members = [];

  setMembers(BuildContext context) {
    List<Member> members =
        (ModalRoute.of(context)!.settings.arguments! as List).first;
    committee = (ModalRoute.of(context)!.settings.arguments! as List).last;

    for (var i = 0; i < members.length; i++) {
      if (members[i].id == committee.leaderID) {
        leader = members[i];
        members.removeAt(i);
      } else if (members[i].id == committee.coLeaderID) {
        coLeader = members[i];
        members.removeAt(i);
      } else {
        this.members.add(members[i]);
      }
    }
  }
}
