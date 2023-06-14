import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../Home/home_view.dart';
import '../events/events_view.dart';
import '../hierarchy/hierarchy_view.dart';
import '../leaderboard/leaderboard_view.dart';
import '../profile/profile_view.dart';
import '../timeline/timeline_view.dart';

class NavigationViewModel extends BaseViewModel {
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  final List<Widget> pages = const [
    HierarchyView(),
    HomeView(),
    LeaderboardView(),
    TimeLineView(),
    EventsView(),
  ];

  void updateScreen(int index) {
    currentTab = index;
    notifyListeners();
  }
}
