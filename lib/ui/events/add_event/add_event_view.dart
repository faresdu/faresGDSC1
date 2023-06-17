import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:gdsc_app/ui/events/add_event/add_event_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../core/utils/constants.dart';

class AddEventView extends StatefulWidget {
  const AddEventView({Key? key}) : super(key: key);

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddEventViewModel>.reactive(
        viewModelBuilder: () => AddEventViewModel(),
        builder: (context, viewmodel, _) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                            'إضافة فعالية',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          viewmodel.image == null
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: InkWell(
                                    onTap: () {
                                      viewmodel.showImagePicker();
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/events/add_image.svg',
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    viewmodel.showImagePicker();
                                  },
                                  child: Image.file(
                                    File(viewmodel.image!.path),
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                          CustomTextField(title: 'العنوان', controller: viewmodel.titleController),
                          Row(
                            children: [
                              Expanded(
                                child: CustomFieldButton(
                                  title: 'التاريخ',
                                  onPressed: () async {
                                    final DateTime? date = await showDatePicker(
                                        context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2040));
                                    setState(() {
                                      viewmodel.dateTime = date;
                                    });
                                  },
                                  icon: SvgPicture.asset('assets/icons/events/date.svg', width: 22),
                                  child: viewmodel.dateTime == null ? const Text('لم يحدد') : Text(DateHelper.getDate(viewmodel.dateTime!)),
                                ),
                              ),
                              Expanded(
                                child: CustomFieldButton(
                                    title: 'الوقت',
                                    onPressed: () async {
                                      final TimeOfDay? time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      setState(() {
                                        viewmodel.timeOfDay = time;
                                      });
                                    },
                                    icon: SvgPicture.asset('assets/icons/events/time.svg', width: 22),
                                    child: viewmodel.timeOfDay == null ? const Text('لم يحدد') : Text(DateHelper.getHourTOD(viewmodel.timeOfDay!))),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomFieldButton(
                                  title: 'النوع',
                                  onPressed: () {
                                    setState(() {
                                      viewmodel.isOnline = !viewmodel.isOnline;
                                    });
                                  },
                                  child: Text(viewmodel.isOnline ? 'اون لاين' : 'حضوري'),
                                ),
                              ),
                              Expanded(
                                child: CustomTextField(
                                  title: 'أقصى عدد للحضور',
                                  controller: viewmodel.attendeesController,
                                  type: TextInputType.number,
                                  icon: SvgPicture.asset(
                                    'assets/icons/events/attendees.svg',
                                  ),
                                ),
                              )
                            ],
                          ),
                          CustomTextField(
                            title: 'الموقع',
                            controller: viewmodel.locationController,
                          ),
                          CustomTextField(
                            title: 'الوصف',
                            controller: viewmodel.descriptionController,
                            maxLines: 4,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: MediaQuery.of(context).size.width * 0.1),
                            child: SubmitButton(onPressed: () {
                              viewmodel.addEvent();
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

  Widget CustomFieldButton({required String title, Widget? icon, onPressed, double? height, Widget? child}) {
    return _TextWithChild(
      title: title,
      child: MaterialButton(
        elevation: 0,
        height: height ?? 47,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                icon ??
                    const SizedBox(
                      width: 22,
                    ),
                Expanded(child: Center(child: child)),
                const SizedBox(
                  width: 22,
                ),
              ],
            ),
          ),
        ),
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
        'إضـافـة',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget CustomTextField(
      {required String title, required TextEditingController controller, autofocus = false, int maxLines = 1, Widget? icon, TextInputType? type}) {
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
}
