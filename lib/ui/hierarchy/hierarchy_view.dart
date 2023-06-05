import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/hierarchy/hierarchy_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/hierarchy_button.dart';
import 'package:stacked/stacked.dart';
import 'package:gdsc_app/ui/userHours/requests_page.dart';

class HierarchyView extends StatefulWidget {
  const HierarchyView({Key? key}) : super(key: key);

  @override
  State<HierarchyView> createState() => _HierarchyViewState();
}

class _HierarchyViewState extends State<HierarchyView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HierarchyViewModel>.reactive(
        viewModelBuilder: () => HierarchyViewModel(),
        onModelReady: (model) => model.getComms(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: const Text('الهيكلة'),
                automaticallyImplyLeading: false),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: viewmodel.comms
                        .map((e) => HierarchyButton(
                            onPressed: () {
                              viewmodel.navigateToCommittee(e);
                            },
                            name: e.name))
                        .toList(),
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Requestspage()));
              },
              child: Icon(Icons.add),
            ),
          );
        });
  }
}
