import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gdsc_app/core/models/bank_account.dart';
import 'package:gdsc_app/core/utils/form_validators.dart';
import 'package:gdsc_app/ui/widgets/submit_button.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/custom_text_form_field.dart';
import 'add_bank_account_viewmodel.dart';

class AddBankAccountView extends StatefulWidget {
  const AddBankAccountView({super.key, this.onSubmit});
  final void Function(BankAccount bank)? onSubmit;

  @override
  State<AddBankAccountView> createState() => _AddBankAccountViewState();
}

class _AddBankAccountViewState extends State<AddBankAccountView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddBankAccountViewModel>.reactive(
        viewModelBuilder: () => AddBankAccountViewModel(),
        builder: (context, viewmodel, _) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 13, bottom: 8),
                    height: 4,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(children: [
                                const Text(
                                  'اضافه حساب بنكي',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Form(
                                  key: viewmodel.formKey,
                                  child: Column(
                                    children: [
                                      CustomTextFormField(
                                        title: 'اسم البنك',
                                        hintText: 'اسم البنك',
                                        validator: (val) =>
                                            FormBuilderValidators.required(
                                                    errorText:
                                                        'الرجاء ادخال اسم البنك')(
                                                val),
                                        onSaved: (val) =>
                                            viewmodel.bankName = val,
                                        controller:
                                            viewmodel.bankNameController,
                                      ),
                                      CustomTextFormField(
                                        title: 'اسم صاحب الحساب',
                                        hintText: 'اسم صاحب الحساب',
                                        validator: (val) =>
                                            FormBuilderValidators.required(
                                                    errorText:
                                                        'الرجاء ادخال اسم صاحب الحساب')(
                                                val),
                                        controller: viewmodel
                                            .accountHolderNameController,
                                        onSaved: (val) =>
                                            viewmodel.accountHolderName = val,
                                      ),
                                      CustomTextFormField(
                                        title: 'رقم الايبان',
                                        hintText: 'رقم الايبان',
                                        validator: FormValidators.ibanValidator,
                                        onSaved: (val) => viewmodel.iban = val,
                                        controller: viewmodel.ibanController,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 100),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                        child: SubmitButton(
                                          isBusy: viewmodel.isBusy,
                                          onPressed: () async {
                                            BankAccount? bank = await viewmodel
                                                .addBankAccount();
                                            if (widget.onSubmit != null &&
                                                bank != null) {
                                              widget.onSubmit!(bank);
                                              Navigator.pop(context);
                                            }
                                          },
                                          text: 'إضـافـة',
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ]))))
                ])),
          );
        });
  }
}
