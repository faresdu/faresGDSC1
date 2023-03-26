import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/events/events_view.dart';
import 'package:gdsc_app/ui/hierarchy/hierarchy_view.dart';
import 'package:gdsc_app/ui/leaderboard/leaderboard_view.dart';
import 'package:gdsc_app/ui/profile/profile_view.dart';
import 'package:gdsc_app/ui/timeline/timeline_view.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:flutter_svg/svg.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  _NavigationViewState createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final List<Widget> pages = [
    const ProfileView(),
    const EventsView(),
    const LeaderboardView(),
    const HierarchyView(),
    const TimeLineView(),
  ];
  final List<BottomNavigationBarItem> items = [
    buildBottomNavigationBarItem("profile"),
    buildBottomNavigationBarItem("events"),
    buildBottomNavigationBarItem("leaderboard"),
    buildBottomNavigationBarItem("hierarchy"),
    buildBottomNavigationBarItem("timeline"),
  ];
  int ind = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: ind,
        children: pages,
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          highlightColor: Constants.blue.withOpacity(.2),
        ),
        child: Container(
          height: 78,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(21)),
            boxShadow: Constants.shadow,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Constants.navigationBackground,
            items: items,
            currentIndex: ind,
            onTap: (index) {
              setState(() {
                ind = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

BottomNavigationBarItem buildBottomNavigationBarItem(String name) {
  return BottomNavigationBarItem(
    label: '',
    activeIcon: SvgPicture.asset("assets/icons/navigation/${name}_active.svg", color: Constants.blue),
    icon: SvgPicture.asset("assets/icons/navigation/${name}.svg", color: Constants.blue),
  );
}
