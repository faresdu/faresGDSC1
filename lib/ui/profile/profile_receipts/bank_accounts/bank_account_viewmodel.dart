import 'package:flutter/cupertino.dart';
import 'package:gdsc_app/core/models/bank_account.dart';
import 'package:gdsc_app/core/services/receipt_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:gdsc_app/ui/profile/profile_receipts/bank_accounts/add_bank_account_view.dart';
import 'package:gdsc_app/ui/widgets/custom_bottom_modal_sheet.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/app/app.locator.dart';

class BankAccountViewModel extends BaseViewModel {
  final receiptService = locator<ReceiptService>();
  final userService = locator<UserService>();

  List<BankAccount> bankAccounts = [];

  getBankAccounts() async {
    setBusy(true);
    bankAccounts = await receiptService.fetchBankAccounts(userService.user.id);
    setBusy(false);
  }

  navigateToAddBankAccount(BuildContext context) {
    CustomModalBottomSheet(context, AddBankAccountView(
      onSubmit: (val) {
        bankAccounts.add(val);
        notifyListeners();
      },
    ));
  }
}
