import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/events/events_view.dart';
import 'package:gdsc_app/ui/hierarchy/hierarchy_view.dart';
import 'package:gdsc_app/ui/leaderboard/leaderboard_view.dart';
import 'package:gdsc_app/ui/profile/profile_view.dart';
import 'package:gdsc_app/ui/timeline/timeline_view.dart';
import 'package:gdsc_app/ui/widgets/navigation_bar_icon.dart';

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
          primarySwatch: Colors.lightGreen,
          highlightColor: Color(0x33547DBF),
        ),
        child: Container(
          height: 78,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(21),
              topRight: Radius.circular(21),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 8),
            ],
          ),
          child: BottomNavigationBar(
            selectedItemColor: Color(0xFF547DBF),
            unselectedItemColor: Color(0x99547DBF),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: '',
                icon: NavigationBarIcon(filename: "assets/icons/members.svg"),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: NavigationBarIcon(filename: "assets/icons/events.svg"),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: NavigationBarIcon(filename: "assets/icons/members.svg"),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: NavigationBarIcon(filename: "assets/icons/club hierarchy.svg"),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: NavigationBarIcon(filename: "assets/icons/timeline.svg"),
              ),
            ],
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
