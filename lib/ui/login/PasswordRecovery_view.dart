import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/form_validators.dart';
import 'package:gdsc_app/ui/login/login_viewmodel.dart';
import 'package:gdsc_app/ui/notifications/notifications_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';
import '../../../core/utils/constants.dart';
import '../../core/utils/helper_functions.dart';

class PasswordRecoverView extends StatefulWidget {
  const PasswordRecoverView({super.key});

  @override
  State<PasswordRecoverView> createState() => _PasswordRecoverViewState();
}

class _PasswordRecoverViewState extends State<PasswordRecoverView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, viewmodel, _) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextFormField(
                  controller: viewmodel.resetPasswordController,
                  title: "البريد الالكتروني",
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                        color: Constants.blueButton,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "استعادة",
                        style: TextStyle(
                            color: Constants.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}

Widget _TextWithChild({required String title, required Widget child}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        child,
      ],
    ),
  );
}

Widget SubmitButton(
    {required Function() onPressed,
    required String text,
    required double sizeX,
    required double sizeY}) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      fixedSize: Size(sizeX, sizeY),
      backgroundColor: Constants.blueButton,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget CustomTextField(
    {required String title,
    required TextEditingController controller,
    autofocus = false,
    int maxLines = 1,
    Widget? icon,
    TextInputType? type}) {
  return _TextWithChild(
    title: title,
    child: TextField(
      maxLength: 125,
      maxLines: maxLines,
      autofocus: autofocus,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: icon,
          ),
          prefixIconConstraints: const BoxConstraints(maxWidth: 22 + 30),
          contentPadding: EdgeInsets.zero,
          fillColor: Colors.white,
          filled: true,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          )),
    ),
  );
}
