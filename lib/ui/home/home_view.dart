import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/Home/home_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:stacked/stacked.dart';
import '../../core/utils/constants.dart';
import 'components/activity_card.dart';
import 'components/notification_card.dart';
import 'components/section_title.dart';
import 'components/welcome_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({required this.updateScreen, Key? key}) : super(key: key);
  final void Function(int index) updateScreen;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = CarouselController();
  int _current = 1;
  double spacing = 45;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onViewModelReady: (model) => model.getNotifications(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            backgroundColor: Constants.background,
            body: BusyOverlay(
              isBusy: viewmodel.isBusy,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
                    child: Column(
                      children: [
                        const Welcome(),
                        SizedBox(
                          height: spacing / 4,
                        ),
                        if (viewmodel.featuredNotification != null)
                          NotificationCard(
                            notification: viewmodel.featuredNotification!,
                            isNetworkImage: false,
                          ),
                        SizedBox(
                          height: spacing / 2,
                        ),
                        if (viewmodel.notifications.isNotEmpty)
                          SectionTitle(
                            title: "التنبيهات",
                            onPressed: () {
                              viewmodel.navigateToNotifications();
                            },
                          ),
                        if (viewmodel.notifications.isNotEmpty)
                          CarouselSlider(
                            carouselController: controller,
                            items: viewmodel.notifications
                                .map((e) => NotificationCard(
                                      notification: e,
                                    ))
                                .toList(),
                            options: CarouselOptions(
                                viewportFraction: 1,
                                height: 115,
                                enableInfiniteScroll: false,
                                initialPage: _current,
                                onPageChanged: (index, reason) {
                                  _current = index;
                                  setState(() {});
                                }),
                          ),
                        if (viewmodel.notifications.isNotEmpty)
                          const SizedBox(height: 10),
                        if (viewmodel.notifications.isNotEmpty)
                          DotsIndicator(
                              dotsCount: viewmodel.notifications.length,
                              position: _current.toDouble(),
                              decorator: const DotsDecorator(
                                color: Constants.inactiveDotColor,
                                activeColor: Constants.primaryLightBlue,
                              ),
                              onTap: (position) {
                                setState(() {
                                  controller.animateToPage(position.toInt(),
                                      duration:
                                          const Duration(milliseconds: 350),
                                      curve: Curves.easeInOut);
                                });
                              }),
                        SizedBox(
                          height: spacing / 2,
                        ),
                        SectionTitle(
                          title: "الفعاليات",
                          onPressed: () {
                            widget.updateScreen(4);
                          },
                        ),
                        SizedBox(
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: viewmodel.events
                                  .map((e) => ActivityCard(
                                      onTap: () {
                                        viewmodel.navigateToEvent(e);
                                      },
                                      signUpButton:
                                          viewmodel.getSignUpButton(e),
                                      event: e))
                                  .toList(),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: !viewmodel.isAdmin()? null : FloatingActionButton(
              heroTag: 'toHoursRequestPage',
              backgroundColor: Constants.primaryLightBlue,
              onPressed: () {
                viewmodel.navigateToRequestsPage();
              },
              child: const Icon(Icons.menu),
            ),
          );
        });
  }
}
