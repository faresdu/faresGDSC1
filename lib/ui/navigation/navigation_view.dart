import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/events/events_view.dart';
import 'package:gdsc_app/ui/hierarchy/hierarchy_view.dart';
import 'package:gdsc_app/ui/leaderboard/leaderboard_view.dart';
import 'package:gdsc_app/ui/profile/profile_view.dart';
import 'package:gdsc_app/ui/timeline/timeline_view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  _NavigationViewState createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();

  final List<Widget> pages = [
    const HierarchyView(),
    const ProfileView(),
    const LeaderboardView(),
    const TimeLineView(),
    const EventsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: IndexedStack(
          index: currentTab,
          children: pages,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: Container(
          color: Colors.white,
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                minWidth: 10,
                onPressed: () {
                  setState(() {
                    currentTab = 4;
                  });
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/events.png',
                      height: 15,
                      color: currentTab == 4
                          ? Color(0xffea4335)
                          : Color(0xfff4938f),
                    ),
                    Text('فعاليات',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: currentTab == 4
                              ? Color(0xffea4335)
                              : Color(0xfff4938f),
                        )),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 10,
                onPressed: () {
                  setState(() {
                    currentTab = 3;
                  });
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/timeline.png',
                      height: 15,
                      color: currentTab == 3
                          ? Color(0xfffbbc05)
                          : Color(0xfffadc86),
                    ),
                    Text(
                      'المنشورات',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: currentTab == 3
                            ? Color(0xfffbbc05)
                            : Color(0xfffadc86),
                      ),
                    ),
                  ],
                ),
              ),

              /// floating action
              MaterialButton(
                minWidth: 20,
                onPressed: () {
                  setState(() {
                    currentTab = 0;
                  });
                },
                child: CircleAvatar(
                  backgroundColor: Color(0xff4285F4),
                  radius: 25,
                  child: Padding(
                    padding: const EdgeInsets.all(13.5),
                    child: Image.asset('assets/images/home.png'),
                  ),
                ),
              ),
              MaterialButton(
                minWidth: 10,
                onPressed: () {
                  setState(() {
                    currentTab = 2;
                  });
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/Vector.png',
                      height: 15,
                      color: currentTab == 2
                          ? Color(0xff34a853)
                          : Color(0xffa4d0a2),
                    ),
                    Text(
                      'المتصدرين',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: currentTab == 2
                            ? Color(0xff34a853)
                            : Color(0xffa4d0a2),
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 10,
                onPressed: () {
                  setState(() {
                    currentTab = 1;
                  });
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      'assets/images/user.png',
                      height: 15,
                      color: currentTab == 1
                          ? Color(0xff4285f4)
                          : Color(0xffbfdef5),
                    ),
                    Text('حسابي',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: currentTab == 1
                              ? Color(0xff4285f4)
                              : Color(0xffbfdef5),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
