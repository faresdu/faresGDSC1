import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import '../../core/utils/constants.dart';
import 'navigation_button.dart';
import 'navigation_viewmodel.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavigationViewModel>.reactive(
        viewModelBuilder: () => NavigationViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            body: PageStorage(
              bucket: viewmodel.bucket,
              child: IndexedStack(
                index: viewmodel.currentTab,
                children: viewmodel.pages,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              child: Container(
                height: 65,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NavigationButton(
                        onPressed: () {
                          viewmodel.updateScreen(4);
                        },
                        color: viewmodel.currentTab == 4
                            ? Constants.red
                            : Constants.darkGrey,
                        text: 'الفعاليات',
                        imagePath: 'assets/icons/navigation2/events.svg'),
                    NavigationButton(
                        onPressed: () {
                          viewmodel.updateScreen(3);
                        },
                        color: viewmodel.currentTab == 3
                            ? Constants.blueButton
                            : Constants.darkGrey,
                        text: 'المنشورات',
                        imagePath: 'assets/icons/navigation2/timeline.svg'),
                    MaterialButton(
                      minWidth: 20,
                      height: double.infinity,
                      shape: const CircleBorder(eccentricity: 0),
                      onPressed: () {
                        viewmodel.updateScreen(0);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        radius: 27,
                        child: CircleAvatar(
                          backgroundColor: Constants.blueButton,
                          radius: 25,
                          child: Padding(
                            padding: const EdgeInsets.all(13.5),
                            child: SvgPicture.asset(
                                'assets/icons/navigation2/home.svg'),
                          ),
                        ),
                      ),
                    ),
                    NavigationButton(
                        onPressed: () {
                          viewmodel.updateScreen(2);
                        },
                        color: viewmodel.currentTab == 2
                            ? Constants.yellow
                            : Constants.darkGrey,
                        text: 'المتصدرين',
                        imagePath: 'assets/icons/navigation2/leaderboard.svg'),
                    NavigationButton(
                        onPressed: () {
                          viewmodel.updateScreen(1);
                        },
                        color: viewmodel.currentTab == 1
                            ? Constants.green
                            : Constants.darkGrey,
                        text: 'حسابي',
                        imagePath: 'assets/icons/navigation2/profile.svg'),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
