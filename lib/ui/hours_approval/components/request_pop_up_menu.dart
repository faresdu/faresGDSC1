import 'package:flutter/material.dart';

import '../../../core/models/hour_request.dart';
import '../../../core/utils/constants.dart';
import '../../../core/utils/helper_functions.dart';

class RequestPopUpMenu extends StatelessWidget {
  const RequestPopUpMenu({
    super.key,
    required this.request,
    required this.onUpdate,
  });

  final HourRequest request;
  final Function(HourRequest request, bool status)? onUpdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(request.createdAt ?? "السبت ، 2023-20-6",
              style: Constants.superSmallText.copyWith(
                color: Constants.black3(context),
                fontWeight: FontWeight.w700,
              )),
        ),
        if (request.approved != null)
          SizedBox(
            height: 25,
            child: PopupMenuButton(
                icon: Icon(
                  Icons.more_horiz,
                  color: Constants.black(context),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                onSelected: (value) async {
                  bool? confirmed = await HelperFunctions.warningDialog(
                    context,
                    title: value == 'reject' ? 'رفض الطلب' : 'قبول الطلب',
                    content:
                        'هل انت متاكد من ${value == 'reject' ? 'رفض' : 'قبول'} الطلب؟',
                    confirmButtonText: 'تاكيد',
                  );
                  if (confirmed == true && onUpdate != null) {
                    onUpdate!(request, value == 'approve');
                  }
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        value: request.approved! ? 'reject' : 'approve',
                        child: Text(
                          request.approved! ? 'رفض الطلب' : 'قبول الطلب',
                          textAlign: TextAlign.center,
                          style: Constants.verySmallText.copyWith(
                              fontWeight: FontWeight.bold,
                              color: request.approved!
                                  ? Constants.negative
                                  : Constants.positive),
                        ),
                      )
                    ]),
          )
      ],
    );
  }
}
