import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/app/app.router.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/services/supabase_service.dart';

class EventParticipantsViewModel extends BaseViewModel {
  final supabaseService = locator<SupabaseService>();
  final navService = locator<NavigationService>();

  List<Member> participants = [];

  getUsers(BuildContext context) async {
    setBusy(true);
    try {
      List<String>? memberIds =
          (ModalRoute.of(context)!.settings.arguments as List<String>?);
      if (memberIds != null && memberIds.isNotEmpty) {
        participants = await supabaseService.getMembers(memberIds);
      }
    } catch (e) {
      print(e);
    }
    setBusy(false);
  }

  navigateToUserProfile(String userId) {
    navService.navigateTo(Routes.profileView, arguments: userId);
  }
}
