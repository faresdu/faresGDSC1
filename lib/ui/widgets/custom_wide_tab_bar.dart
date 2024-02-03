import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class CustomWideTabBar extends StatelessWidget {
  const CustomWideTabBar({
    super.key,
    required this.children,
    required this.length,
    required this.tabs,
  });

  final int length;
  final List<Widget> children;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: length,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            decoration: BoxDecoration(
                boxShadow: Constants.shadow3,
                color: Constants.white,
                borderRadius: BorderRadius.circular(25)),
            width: MediaQuery.of(context).size.width * 0.93,
            child: TabBar(
              unselectedLabelStyle: Constants.smallText
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w700),
              labelStyle: Constants.smallText
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w700),
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: Constants.blueButton,
                borderRadius: BorderRadius.circular(25),
              ),
              tabs: tabs,
            ),
          ),
          Expanded(
            child: TabBarView(
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
