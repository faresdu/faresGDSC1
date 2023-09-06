import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/Home/home_view.dart';
import 'package:stacked/stacked.dart';
import '../events/events_view.dart';
import '../leaderboard/leaderboard_view.dart';
import '../profile/profile_view.dart';
import '../timeline/timeline_view.dart';

class NavigationViewModel extends BaseViewModel {
  int currentTab = 0;

  NavigationViewModel() {
    pages = [
      HomeView(updateScreen: updateScreen),
      const ProfileView(),
      const LeaderboardView(),
      const TimeLineView(),
      const EventsView(),
    ];
  }

  final PageStorageBucket bucket = PageStorageBucket();
  late List<Widget> pages = [];

  void updateScreen(int index) {
    currentTab = index;
    notifyListeners();
  }
}
