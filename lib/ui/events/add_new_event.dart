import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/constants.dart';

class AddEventView extends StatefulWidget {
  const AddEventView({Key? key}) : super(key: key);

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

class _AddEventViewState extends State<AddEventView> {
  TextEditingController titleController = TextEditingController();
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  bool isOnline = false;
  TextEditingController attendeesController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        image = await picker.pickImage(source: ImageSource.gallery);
                      },
                      icon: SvgPicture.asset('assets/icons/events/add_image.svg'),
                    ),
                  ),
                  CustomField(
                    title: 'العنوان',
                    child: TextField(
                      maxLines: 1,
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: '',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomField(
                          title: 'التاريخ',
                          onPressed: () async {
                            final DateTime? date = await showDatePicker(
                                context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2040));
                            setState(() {
                              dateTime = date;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icons/events/date.svg', width: 22),
                                Expanded(
                                  child: Center(
                                    child: dateTime == null ? const Text('لم يحدد') : Text(DateHelper.getDate(dateTime!)),
                                  ),
                                ),
                                const SizedBox(width: 22),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomField(
                          title: 'الوقت',
                          onPressed: () async {
                            final TimeOfDay? time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            setState(() {
                              timeOfDay = time;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icons/events/time.svg', width: 22),
                                Expanded(
                                  child: Center(
                                    child: timeOfDay == null ? const Text('لم يحدد') : Text(DateHelper.getHourTOD(timeOfDay!)),
                                  ),
                                ),
                                const SizedBox(width: 22),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: CustomField(
                            title: 'النوع',
                            onPressed: () {
                              setState(() {
                                isOnline = !isOnline;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Center(child: Text(isOnline ? 'اون لاين' : 'حضوري')),
                            )),
                      ),
                      Expanded(
                        child: CustomField(
                          title: 'أقصى عدد للحضور',
                          height: 45,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/icons/events/attendees.svg', width: 22,),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: attendeesController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  CustomField(
                    title: 'الموقع',
                    height: 45,
                    child: TextField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ),
                  ),
                  CustomField(
                    title: 'الوصف',
                    height: 4 * 45,
                    child: TextField(
                      maxLines: 4,
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: MediaQuery.of(context).size.width * 0.1),
                    child: SubmitButton(),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget CustomField({required String title, Widget? child, onPressed, double? height}) {
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
          GestureDetector(
            onTap: onPressed,
            child: Container(
              height: height ?? 45,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget SubmitButton() {
    return TextButton(
      onPressed: () {
        if (dateTime != null && timeOfDay != null) {
          DateTime d = DateTime(dateTime!.year, dateTime!.month, dateTime!.day, timeOfDay!.hour, timeOfDay!.minute);
          print(titleController.value.text);
          print('$d');
          print(isOnline);
          print(attendeesController.value.text);
          print(locationController.value.text);
          print(descriptionController.value.text);
          print(image?.path);
        }
      },
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
}
