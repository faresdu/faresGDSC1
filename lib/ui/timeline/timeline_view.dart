import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/timeline/timeline_viewmodel.dart';
import 'package:stacked/stacked.dart';

class TimeLineView extends StatefulWidget {
  const TimeLineView({Key? key}) : super(key: key);

  @override
  _TimeLineViewState createState() => _TimeLineViewState();
}

class _TimeLineViewState extends State<TimeLineView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimeLineViewModel>.reactive(
        viewModelBuilder: () => TimeLineViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(title: Text('Timeline')),
          );
        });
  }
}
