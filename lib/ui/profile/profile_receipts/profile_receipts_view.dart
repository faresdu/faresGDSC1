import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/profile/profile_receipts/profile_receipts_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/circle_button.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/submit_button.dart';
import 'package:stacked/stacked.dart';

import '../../widgets/custom_tab_bar.dart';

class ProfileReceiptsView extends StatelessWidget {
  const ProfileReceiptsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileReceiptsViewModel>.reactive(
        viewModelBuilder: () => ProfileReceiptsViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
              appBar: CustomAppBar(
                title: 'طلبات الفواتير ',
                actions: [
                  SizedBox(
                    width: 90,
                    child: SubmitButton(
                      outlined: true,
                      onPressed: () => viewmodel.navigateToBankAccounts(),
                      style: Constants.verySmallText.copyWith(height: 1.4),
                      text: 'حساباتي\nالبنكيه',
                    ),
                  ),
                ],
              ),
              backgroundColor: Constants.background,
              body: SafeArea(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      CustomTabBar(
                        tabs: const [
                          Tab(
                            text: 'الحاليه',
                          ),
                          Tab(
                            text: 'السابقه',
                          ),
                        ],
                        widget: CircleButton(onPressed: () {}),
                      ),
                      const Expanded(
                          child: TabBarView(children: [Column(), Column()]))
                    ],
                  ),
                  // key: view,
                ),
              ));
        });
  }
}
