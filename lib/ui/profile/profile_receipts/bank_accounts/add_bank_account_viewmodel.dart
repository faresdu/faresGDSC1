import 'package:flutter/material.dart';
import 'package:gdsc_app/core/app/app.locator.dart';
import 'package:gdsc_app/core/services/receipt_service.dart';
import 'package:gdsc_app/core/services/user_service.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/models/bank_account.dart';

class AddBankAccountViewModel extends BaseViewModel {
  final receiptService = locator<ReceiptService>();
  final userService = locator<UserService>();
  final formKey = GlobalKey<FormState>();

  final TextEditingController ibanController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountHolderNameController =
      TextEditingController();

  String? bankName;
  String? iban;
  String? accountHolderName;

  Future<BankAccount?> addBankAccount() async {
    if (!formKey.currentState!.validate()) {
      return null;
    }
    setBusy(true);
    //Success
    formKey.currentState?.save();
    final bank = BankAccount(
      bankName: bankName!,
      iban: iban!,
      accountHolderName: accountHolderName!,
      userId: userService.user.id,
    );

    return await receiptService.createBankAccount(bank).whenComplete(() {
      setBusy(false);
    });
  }
}
