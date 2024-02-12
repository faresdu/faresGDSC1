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
            bottomNavigationBar: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15),
                ),
                boxShadow: kElevationToShadow[4],
              ),
              child: BottomAppBar(
                elevation: 0,
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
                      visualDensity: VisualDensity.compact,
                      shape: const CircleBorder(eccentricity: 0),
                      onPressed: () {
                        viewmodel.updateScreen(0);
                      },
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Constants.blueButton,
                          radius: 20,
                          child: SvgPicture.asset(
                              'assets/icons/navigation2/home.svg'),
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
// NavigationBar(
// backgroundColor: Colors.white,
// selectedIndex: viewmodel.currentTab,
// onDestinationSelected: viewmodel.updateScreen,
// destinations: [
// NavigationDestination(
// icon: SvgPicture.asset('assets/icons/navigation2/events.svg'),
// label: 'الفعاليات',
// ),
// NavigationDestination(
// icon:
// SvgPicture.asset('assets/icons/navigation2/timeline.svg'),
// label: 'المنشورات',
// ),
// NavigationDestination(
// icon: Image.asset('assets/images/GDSC/GDSC.png', width: 65,),
// label: 'الرئيسية',
// ),
// NavigationDestination(
// icon: SvgPicture.asset('assets/icons/navigation2/leaderboard.svg'),
// label: 'المتصدرين',
// ),
// NavigationDestination(
// icon: SvgPicture.asset('assets/icons/navigation2/profile.svg'),
// label: 'حسابي',
// ),
// ],
// )
