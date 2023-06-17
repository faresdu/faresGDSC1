import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/notifications/notifications_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:stacked/stacked.dart';

import '../../core/utils/constants.dart';
import '../Home/components/notification_card.dart';
import '../widgets/notifications_card.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationsViewModel>.reactive(
      viewModelBuilder: () => NotificationsViewModel(),
      onViewModelReady: (model) => model.getNotifications(),
      builder: (context, viewmodel, _) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              color: Constants.background,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 18),
                        const Text(
                          "التنبيهات",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "الصفحة الرئيسية",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios, size: 25),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: BusyOverlay(
                        isBusy: viewmodel.isBusy,
                        child: ListView(
                          shrinkWrap: true,
                          children: viewmodel.notifications
                              .map((e) => Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: NotificationCard(notification: e)))
                              .toList(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
