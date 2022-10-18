import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/hierarchy/hierarchy_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HierarchyView extends StatelessWidget {
  const HierarchyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HierarchyViewModel>.reactive(
        viewModelBuilder: () => HierarchyViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(title: const Text('Hierarchy')),
          );
        });
  }
}
