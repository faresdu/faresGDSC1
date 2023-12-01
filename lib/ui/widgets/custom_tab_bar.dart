import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class CustomTapBar extends StatelessWidget {
  const CustomTapBar({Key? key, this.widget, required this.tabs})
      : super(key: key);

  final Widget? widget;
  final List<Tab> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: Row(
        children: [
          Flexible(
            flex: widget == null ? 1 : 0,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: Constants.shadow3,
                  color: Constants.white,
                  borderRadius: BorderRadius.circular(25)),
              // margin: EdgeInsets.all(9),
              width: widget == null
                  ? null
                  : MediaQuery.of(context).size.width * 0.75,
              child: TabBar(
                  unselectedLabelStyle: Constants.smallText.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w700),
                  labelStyle: Constants.smallText.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                      color: Constants.blueButton,
                      borderRadius: BorderRadius.circular(25)),
                  tabs: tabs),
            ),
          ),
          if (widget != null) ...[const Spacer(), widget!]
        ],
      ),
    );
  }
}
