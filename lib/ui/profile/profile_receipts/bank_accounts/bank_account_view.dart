import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/profile/profile_receipts/bank_accounts/components/bank_account_card.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/utils/constants.dart';
import 'bank_account_viewmodel.dart';

class BankAccountView extends StatelessWidget {
  const BankAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BankAccountViewModel>.reactive(
        onViewModelReady: ((viewModel) => viewModel.getBankAccounts()),
        viewModelBuilder: () => BankAccountViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: "حساباتي البنكيه",
            ),
            backgroundColor: Constants.background,
            body: SafeArea(
              child: BusyOverlay(
                isBusy: viewmodel.isBusy,
                child: ListView(
                  children: viewmodel.bankAccounts
                      .map((b) => BankAccountCard(bankAccount: b))
                      .toList(),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => viewmodel.navigateToAddBankAccount(context),
              backgroundColor: Constants.primary,
              heroTag: 'addBankTag',
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          );
        });
  }
}
