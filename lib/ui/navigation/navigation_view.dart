import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gdsc_app/ui/events/events_view.dart';
import 'package:gdsc_app/ui/hierarchy/hierarchy_view.dart';
import 'package:gdsc_app/ui/profile/profile_view.dart';
import 'package:gdsc_app/ui/timeline/timeline_view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  _NavigationViewState createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final List<Widget> pages = [const TimeLineView(), const HierarchyView(), const EventsView(), const ProfileView()];
  int ind = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: ind,
        children: pages,
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: Theme(
        data: ThemeData(
          primarySwatch: Colors.lightGreen,
          highlightColor: Colors.black,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.green,
          backgroundColor: Colors.indigoAccent,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(label: 'TimeLine', icon: SvgPicture.asset("assets/icons/ETH_icon.svg")),
            BottomNavigationBarItem(label: 'Hierarchy', icon: SvgPicture.asset("assets/icons/ETH_icon.svg")),
            BottomNavigationBarItem(label: 'Events', icon: SvgPicture.asset("assets/icons/ETH_icon.svg")),
            BottomNavigationBarItem(label: 'Profile', icon: SvgPicture.asset("assets/icons/ETH_icon.svg")),
          ],
          currentIndex: ind,
          onTap: (index) {
            setState(() {
              ind = index;
            });
          },
        ),
      ),
    );
  }
}
