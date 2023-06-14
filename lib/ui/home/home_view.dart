import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gdsc_app/ui/events/event_details_view.dart';
import '../../core/utils/constants.dart';
import 'components/activity_card.dart';
import 'components/notification_card.dart';
import 'components/section_title.dart';
import 'components/welcome_widget.dart';
//import 'dart:ui' as dart_ui;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = CarouselController();
  int _current = 1;
  double spacing = 45;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.greyBackground1,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
            child: Column(
              children: [
                Welcome(),
                SizedBox(height: spacing/4,),
                NotificationCard(
                  title: "أكملت 30 ساعة تطوعية",
                  body: "أكملت لجنتك 500 ساعة تطوعية",
                  imagePath: "assets/images/achievement.png",
                ),
                SizedBox(height: spacing,),
                SectionTitle(title: "التنبيهات"),
                
                CarouselSlider(
                  carouselController: controller,
                  items: [

                    NotificationCard(
                      title: "أكملت 30 ة",
                      body: "أكملت لجنتك 500 ساعة تطوعية",
                      imagePath: "assets/images/achievement.png",
                    ),
                    NotificationCard(
                      title: "تعبئة صفحة الساعات",
                      body: "يوسف الغصن",
                      imagePath: "assets/images/empty.png",
                    ),
                    NotificationCard(
                      title: "أكملت 30 ة",
                      body: "أكملت لجنتك 500 ساعة تطوعية",
                      imagePath: "assets/images/achievement.png",
                    ),
                ], options: CarouselOptions(
                  viewportFraction: 1,
                  height: 115,
                  enableInfiniteScroll: false,
                  initialPage: _current,
                  onPageChanged: (index, reason){
                    _current = index;
                    setState(() {});
                  }
                ),),
                SizedBox(height: 10),
                DotsIndicator(
                  dotsCount: 3,
                  position: _current.toDouble(),
                    decorator:const DotsDecorator(
                      //activeSize: dart_ui.Size.square(12.0), UI not responding error
                      color: Constants.inactiveDotColor,
                      activeColor: Constants.primaryLightBlue,
                    ),
                    onTap: (position) {
                      setState(() {
                         controller.animateToPage(
                             position.toInt(),
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut);
                      });
                    }
                ),

                SizedBox(height: spacing,),
                SectionTitle(title: "الفعاليات"),
                SizedBox(
                  height: 175,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index){
                    return ActivityCard();
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}







