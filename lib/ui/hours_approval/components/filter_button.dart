import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    required this.selectedSemesterWeeksList,
    required this.onPressed,
    super.key,
  });

  final List<int> selectedSemesterWeeksList;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
          color: selectedSemesterWeeksList.isNotEmpty
              ? Constants.lightBlue.withOpacity(0.4)
              : null,
          border: selectedSemesterWeeksList.isNotEmpty
              ? Border.all(
                  color: Constants.primaryLightBlue,
                  width: 2,
                )
              : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.filter_alt_outlined,
            size: 25,
            color: selectedSemesterWeeksList.isNotEmpty
                ? Constants.blueButton
                : Constants.black,
          ),
          constraints: BoxConstraints(),
          padding: EdgeInsets.all(8),
        ));
  }
}
