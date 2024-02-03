import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {Key? key, this.widget, required this.tabs, this.tabBarWidthMultiplier})
      : super(key: key);

  final Widget? widget;
  final List<Tab> tabs;
  final double? tabBarWidthMultiplier;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Row(
        children: [
          Flexible(
            flex: widget == null ? 1 : 0,
            child: SizedBox(
              width: widget == null
                  ? null
                  : MediaQuery.of(context).size.width *
                      (tabBarWidthMultiplier ?? 0.75),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                clipBehavior: Clip.antiAlias,
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelStyle: Constants.smallText.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w700),
                  labelStyle: Constants.smallText.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                    color: Constants.blueButton,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  splashBorderRadius: BorderRadius.circular(25),
                  tabs: tabs,
                ),
              ),
            ),
          ),
          if (widget != null) ...[const Spacer(), widget!]
        ],
      ),
    );
  }
}
