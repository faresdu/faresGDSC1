import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:gdsc_app/ui/events/add_event/add_event_viewmodel.dart';
import 'package:gdsc_app/ui/timeline/timeline_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../core/utils/constants.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key});

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimeLineViewModel>.reactive(
        viewModelBuilder: () => TimeLineViewModel(),
        builder: (context, viewmodel, _) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const Text(
                            'إضافة منشور',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          CustomTextField(
                            title: 'الوصف',
                            controller: viewmodel.descriptionController,
                            maxLines: 4,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 100),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1),
                            child: SubmitButton(onPressed: () {
                              // viewmodel.addPost();
                              Navigator.pop(context);
                            }),
                          ),
                        ],
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
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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

Widget SubmitButton({required Function() onPressed}) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      minimumSize: const Size(double.infinity, 35),
      backgroundColor: Constants.blueButton,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    child: const Text(
      'نشر',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
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
      keyboardType: type,
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
