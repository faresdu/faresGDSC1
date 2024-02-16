import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/Home/components/section_title.dart';

import '../../../core/models/notifications.dart';
import '../../../core/utils/constants.dart';
import '../../notifications/components/notification_card.dart';

class FeaturedNotifications extends StatefulWidget {
  const FeaturedNotifications(
      {Key? key, required this.onPressed, required this.notifications})
      : super(key: key);
  final void Function() onPressed;
  final List<Notifications> notifications;

  @override
  State<FeaturedNotifications> createState() => _FeaturedNotificationsState();
}

class _FeaturedNotificationsState extends State<FeaturedNotifications> {
  final controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: "التنبيهات",
          onPressed: widget.onPressed,
        ),
        CarouselSlider(
          carouselController: controller,
          items: widget.notifications
              .map((e) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: NotificationCard(
                      notification: e,
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
              viewportFraction: 1,
              height: 116,
              enableInfiniteScroll: false,
              initialPage: _current,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              onPageChanged: (index, reason) {
                _current = index;
                setState(() {});
              }),
        ),
        const SizedBox(height: 10),
        DotsIndicator(
            dotsCount: widget.notifications.length,
            position: _current.toDouble(),
            decorator: const DotsDecorator(
              color: Constants.infoLight,
              activeColor: Constants.primary,
            ),
            onTap: (position) {
              setState(() {
                controller.animateToPage(position.toInt(),
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut);
              });
            }),
      ],
    );
  }
}
