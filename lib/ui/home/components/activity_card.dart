import 'package:flutter/cupertino.dart';

import '../../../core/utils/constants.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: 175,
      width: 140,
      decoration: BoxDecoration(
        color: Constants.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}