import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/widgets/custom_tab_bar.dart';

class CustomTabBarController extends StatelessWidget {
  const CustomTabBarController({
    super.key,
    required this.children,
    required this.length,
    required this.tabs,
    this.button,
    this.controllerKey,
  });

  final int length;
  final List<Widget> children;
  final List<Tab> tabs;
  final Widget? button;
  final Key? controllerKey;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: length,
      key: controllerKey,
      child: Column(
        children: [
          CustomTabBar(
            tabs: tabs,
            widget: button,
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
