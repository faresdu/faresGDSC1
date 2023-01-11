import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/hierarchy/hierarchy_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/hierarchy_button.dart';
import 'package:stacked/stacked.dart';

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
                title: const Text('Hierarchy'),
                automaticallyImplyLeading: false),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: viewmodel.comms
                      .map((e) =>
                          HierarchyButton(onPressed: () {}, name: e.name))
                      .toList(),
                )
              ],
            ),
          );
        });
  }
}
