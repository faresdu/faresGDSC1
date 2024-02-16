import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/hierarchy/hierarchy_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/hierarchy_button.dart';
import 'package:stacked/stacked.dart';

class HierarchyView extends StatefulWidget {
  const HierarchyView({Key? key}) : super(key: key);

  @override
  State<HierarchyView> createState() => _HierarchyViewState();
}

class _HierarchyViewState extends State<HierarchyView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HierarchyViewModel>.reactive(
        viewModelBuilder: () => HierarchyViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: 'الهيكلة',
            ),
            backgroundColor: Constants.isDarkMode(context)
                ? Constants.background(context)
                : Constants.grayBackGround(context),
            body: SafeArea(
              child: BusyOverlay(
                isBusy: viewmodel.isBusy,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: viewmodel.committees
                        .map((c) => HierarchyButton(
                            onPressed: () {
                              viewmodel.navigateToCommittee(c);
                            },
                            committee: c))
                        .toList(),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
