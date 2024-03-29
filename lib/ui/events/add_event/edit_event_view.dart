import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gdsc_app/core/models/event.dart';
import 'package:gdsc_app/core/utils/date_helper.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';
import 'package:gdsc_app/ui/events/add_event/add_event_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/submit_button.dart';
import 'package:stacked/stacked.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/form_validators.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/show_snackbar.dart';

class EditEventView extends StatefulWidget {
  const EditEventView({Key? key, required this.eventDetails}) : super(key: key);
  final Event eventDetails;

  @override
  State<EditEventView> createState() => _AddEventViewState();
}

class _AddEventViewState extends State<EditEventView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddEventViewModel>.reactive(
        viewModelBuilder: () => AddEventViewModel(),
        onViewModelReady: (model) => model.setEventDetails(widget.eventDetails),
        builder: (context, viewmodel, _) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Padding(
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
                        child: Form(
                          key: viewmodel.formKey,
                          child: Column(
                            children: [
                              Text(
                                'تعديل فعالية',
                                style: Constants.largeText.copyWith(
                                  color: Constants.black(context),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(right: 4, bottom: 4),
                                    child: SubmitButton(
                                      text: "حذف الفعاليه",
                                      color:
                                          Constants.negative.withOpacity(0.85),
                                      onPressed: () async {
                                        bool? confirmed = await viewmodel
                                            .confirmDeletionDialog(context);
                                        if (confirmed == true) {
                                          await viewmodel.deleteEvent();
                                          Navigator.pop(context);
                                        }
                                      },
                                      width: 20,
                                      height: 10,
                                    ),
                                  ),
                                  viewmodel.image == null
                                      ? InkWell(
                                          onTap: () {
                                            viewmodel.showImagePicker();
                                          },
                                          child: viewmodel.isBusy
                                              ? const CircularProgressIndicator()
                                              : viewmodel.oldImage != null
                                                  ? HelperFunctions
                                                      .profileImage(
                                                      imageUrl:
                                                          viewmodel.oldImage!,
                                                      height: 200,
                                                      width: 200,
                                                      fit: BoxFit.contain,
                                                    )
                                                  : SvgPicture.asset(
                                                      'assets/icons/events/add_image.svg',
                                                      height: 24,
                                                      width: 24,
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
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                ],
                              ),
                              CustomTextFormField(
                                title: 'العنوان',
                                controller: viewmodel.titleController,
                                validator: FormBuilderValidators.required(
                                    errorText: 'الرجاء ادخال العنوان'),
                                maxLength: 30,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      title: 'التاريخ',
                                      hintText: 'لم يحدد',
                                      controller: viewmodel.dateTimeController,
                                      enableInteractiveSelection: false,
                                      validator: FormBuilderValidators.required(
                                          errorText: 'الرجاء ادخال التاريخ'),
                                      onTap: () async {
                                        final DateTime? date =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime(2040));
                                        setState(() {
                                          viewmodel.dateTime = date;
                                          viewmodel.dateTimeController.text =
                                              date != null
                                                  ? DateHelper.getDate(date)
                                                  : '';
                                        });
                                      },
                                      icon: SvgPicture.asset(
                                          'assets/icons/events/date.svg',
                                          width: 22),
                                    ),
                                  ),
                                  Expanded(
                                      child: CustomTextFormField(
                                    title: 'الوقت',
                                    hintText: 'لم يحدد',
                                    controller: viewmodel.timeOfDayController,
                                    enableInteractiveSelection: false,
                                    icon: SvgPicture.asset(
                                        'assets/icons/events/time.svg',
                                        width: 22),
                                    validator: FormBuilderValidators.required(
                                        errorText: 'الرجاء ادخال الوقت'),
                                    onTap: () async {
                                      final TimeOfDay? time =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      );
                                      setState(() {
                                        viewmodel.timeOfDay = time;
                                        viewmodel.timeOfDayController.text =
                                            time != null
                                                ? DateHelper.getHourTOD(time)
                                                : '';
                                      });
                                    },
                                  )),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomFieldButton(
                                      title: 'النوع',
                                      onPressed: () {
                                        setState(() {
                                          viewmodel.isOnline =
                                              !viewmodel.isOnline;
                                        });
                                      },
                                      child: Text(
                                        viewmodel.isOnline
                                            ? 'اون لاين'
                                            : 'حضوري',
                                        style: Constants.verySmallText.copyWith(
                                            color: Constants.black(context)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomTextFormField(
                                      title: 'أقصى عدد للحضور',
                                      hintText: 'لم يحدد',
                                      controller: viewmodel.attendeesController,
                                      validator: FormValidators
                                          .eventAttendeesValidator,
                                      type: TextInputType.number,
                                      icon: SvgPicture.asset(
                                        'assets/icons/events/attendees.svg',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              CustomTextFormField(
                                title: 'الموقع',
                                hintText: 'موقع الفعاليه',
                                controller: viewmodel.locationController,
                                validator: FormBuilderValidators.required(
                                    errorText: 'الرجاء ادخال الموقع'),
                                maxLength: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: CustomTextFormField(
                                  title: 'رابط الموقع',
                                  hintText: 'إن وجد',
                                  controller: viewmodel.locationLinkController,
                                  validator: (value) =>
                                      FormValidators.linkValidator(value,
                                          required: false),
                                ),
                              ),
                              CustomTextFormField(
                                title: 'المحاضر أو المضيف',
                                hintText: 'ان وجد',
                                controller: viewmodel.hostController,
                                maxLength: 25,
                              ),
                              CustomTextFormField(
                                title: 'الوصف',
                                hintText: 'وصف الفعاليه',
                                controller: viewmodel.descriptionController,
                                maxLines: 4,
                                maxLength: 150,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.1),
                                child: viewmodel.isBusy
                                    ? const CircularProgressIndicator()
                                    : SubmitButton(
                                        text: 'تعديل',
                                        onPressed: () async {
                                          await viewmodel.editEvent();
                                          if (viewmodel.added) {
                                            Navigator.pop(context);
                                            showSnackBar(context,
                                                success: true,
                                                message:
                                                    'تم تعديل الفعاليه بنجاح');
                                          }
                                        }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
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
            style: Constants.mediumText.copyWith(
              color: Constants.black(context),
              fontWeight: FontWeight.w700,
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

  Widget CustomFieldButton(
      {required String title,
      Widget? icon,
      onPressed,
      double? height,
      Widget? child}) {
    return _TextWithChild(
      title: title,
      child: MaterialButton(
        elevation: 0,
        height: height ?? 47,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Constants.background(context),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Constants.background(context)),
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
}
