import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/bank_account.dart';
import 'package:gdsc_app/core/utils/constants.dart';

class BankAccountCard extends StatelessWidget {
  const BankAccountCard({required this.bankAccount, Key? key})
      : super(key: key);

  final BankAccount bankAccount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        boxShadow: Constants.shadow,
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            bankAccount.bankName,
            style: Constants.largeText
                .copyWith(fontWeight: FontWeight.w700, height: 1.4),
          ),
          SizedBox(
            width: 30,
            height: 40,
            child: VerticalDivider(
              color: Constants.lightGrey,
              thickness: 2,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bankAccount.accountHolderName,
                      style: Constants.verySmallText
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      bankAccount.iban,
                      style: Constants.verySmallText
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
