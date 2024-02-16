import 'package:flutter/material.dart';

import '../../../core/utils/constants.dart';

class FilterOptions extends StatelessWidget {
  const FilterOptions({
    super.key,
    required this.selectedSemesterWeeksList,
    required this.selectedWeeksText,
  });

  final List<int> selectedSemesterWeeksList;
  final String selectedWeeksText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // container that shows the number of weeks selected
        if (selectedSemesterWeeksList.isNotEmpty)
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
              color: Constants.infoLight.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              selectedWeeksText,
              style: Constants.smallText.copyWith(
                  color: Constants.primary, fontWeight: FontWeight.w700),
            ),
          ),
      ],
    );
  }
}
