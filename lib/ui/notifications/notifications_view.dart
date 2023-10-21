import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/notifications/notifications_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/custom_bottom_modal_sheet.dart';
import 'package:stacked/stacked.dart';

import '../../core/utils/constants.dart';
import 'components/notification_card.dart';
import 'add_notifitcaion_view.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationsViewModel>.reactive(
      viewModelBuilder: () => NotificationsViewModel(),
      onViewModelReady: (model) => model.getNotifications(),
      builder: (context, viewmodel, _) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: !viewmodel.isAdmin()? null : FloatingActionButton(
            heroTag: null,
            onPressed: () {
              CustomModalBottomSheet(context, const AddNotification());
            },
            backgroundColor: Constants.blueButton,
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
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
                        const Spacer(),
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
                                  margin: const EdgeInsets.symmetric(vertical: 10),
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
