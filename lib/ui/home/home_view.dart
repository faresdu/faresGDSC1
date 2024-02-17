import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/Home/home_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:stacked/stacked.dart';

import '../notifications/components/notification_card.dart';
import 'components/featured_events.dart';
import 'components/featured_notifications.dart';
import 'components/welcome_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({required this.updateScreen, Key? key}) : super(key: key);
  final void Function(int index) updateScreen;

  @override
  Widget build(BuildContext context) {
    double spacing = MediaQuery.of(context).size.height / 4;
    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.Notifications.requestPermission(true);
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        onViewModelReady: (model) => model.init(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            body: SafeArea(
              child: BusyOverlay(
                isBusy: viewmodel.isBusy,
                child: RefreshIndicator(
                  onRefresh: viewmodel.refreshData,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: spacing / 16,
                        ),
                        Welcome(
                            user: viewmodel.user,
                            currentWeek: viewmodel.currentWeek),
                        SizedBox(
                          height: spacing / 8,
                        ),
                        if (viewmodel.featuredNotification != null) ...[
                          NotificationCard(
                            notification: viewmodel.featuredNotification!,
                          ),
                          SizedBox(
                            height: spacing / 8,
                          )
                        ],
                        if (viewmodel.notifications.isNotEmpty)
                          FeaturedNotifications(
                            onPressed: () =>
                                viewmodel.navigateToNotifications(),
                            notifications: viewmodel.notifications,
                          ),
                        FeaturedEvents(
                          updateScreen: updateScreen,
                          events: viewmodel.events,
                          navigateToEvent: viewmodel.navigateToEvent,
                          getSignUpButton: viewmodel.getSignUpButton,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: !viewmodel.isHrAdmin()
                ? null
                : FloatingActionButton(
                    heroTag: null,
                    onPressed: () =>
                        viewmodel.navigateToCommitteesRequestsPage(),
                    child: const Icon(Icons.menu),
                  ),
          );
        });
  }
}
