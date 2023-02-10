import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/gdsc_user.dart';
import 'package:gdsc_app/ui/timeline/timeline_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

class TimeLineView extends StatefulWidget {
  const TimeLineView({Key? key}) : super(key: key);

  @override
  _TimeLineViewState createState() => _TimeLineViewState();
}

class _TimeLineViewState extends State<TimeLineView> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<GDSCUser>(context);
    return ViewModelBuilder<TimeLineViewModel>.reactive(
      viewModelBuilder: () => TimeLineViewModel(),
      builder: (context, viewmodel, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Timeline')),
          body: Column(children: [
            Text(
              'Welcome Back ${user.name} !!',
              style: TextStyle(fontSize: 30),
            )
          ]),
        );
      },
    );
  }
}
