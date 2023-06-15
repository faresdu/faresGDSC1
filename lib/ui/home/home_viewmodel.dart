import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../core/app/app.locator.dart';
import '../../core/app/app.router.dart';
import '../../core/utils/constants.dart';
import '../events/components/events_card_signup_button.dart';

class HomeViewModel extends BaseViewModel {
  final navService = locator<NavigationService>();

  Map<String, String> mainNotification = {
    "title": "أكملت 30 ساعة تطوعية",
    "body": "أكملت لجنتك 500 ساعة تطوعية",
    "imagePath": "assets/images/achievement.png"
  };
  List<Map<String, String>> featuredNotifications = [
    {
      "title": "أكملت 36 ة",
      "body": "أكملت لجنتك 500 ساعة تطوعية",
      "imagePath": "assets/images/achievement.png"
    },
    {
      "title": "تعبئة صفحة الساعات",
      "body": "يوسف الغصن",
      "imagePath": "assets/images/empty.png"
    },
    {
      "title": "أكملت 30 ة",
      "body": "أكملت لجنتك 500 ساعة تطوعية",
      "imagePath": "assets/images/achievement.png",
    }
  ];

  Widget getSignUpButton() {
    return EventCardButton(
      text: 'احجز مقعدك',
      color: Constants.green.withOpacity(.9),
      onPressed: () {
        print('pressed');
      },
    );
  }

  navigateToRequestsPage() {
    navService.navigateTo(Routes.hoursRequestView);
  }
}
