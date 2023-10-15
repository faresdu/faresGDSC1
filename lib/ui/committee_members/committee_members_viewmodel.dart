import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../core/models/committee.dart';

class CommitteeMembersViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();

  Member? leader;
  Member? coLeader;
  late Committee committee;
  List<Member> members = [];

  setMembers(BuildContext context) {
    List<Member> tempMembers =
        (ModalRoute.of(context)!.settings.arguments! as List).first;

    committee = (ModalRoute.of(context)!.settings.arguments! as List).last;
    for (var i = 0; i < tempMembers.length; i++) {
      if (tempMembers[i].id == committee.leaderID) {
        leader = tempMembers[i];
      } else if (tempMembers[i].id == committee.coLeaderID) {
        coLeader = tempMembers[i];
      } else {
        members.add(tempMembers[i]);
      }
    }
  }

  void navigateToMemberProfile(String memberId) {
    navService.navigateTo(Routes.profileView, arguments: memberId);
  }
}
