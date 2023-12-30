import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../core/utils/constants.dart';

class DeletableItemCard<T> extends StatelessWidget {
  const DeletableItemCard(
      {super.key,
      required this.item,
      required this.onDelete,
      required this.widget,
      this.endAction = false});
  final T item;
  final void Function(T item) onDelete;
  final bool endAction;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    final action = ActionPane(
      extentRatio: 0.2,
      motion: const ScrollMotion(),
      children: [
        Builder(builder: (cont) {
          return ElevatedButton(
            onPressed: () {
              onDelete(item);
              Slidable.of(cont)?.close();
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: Constants.red.withOpacity(0.9),
              padding: const EdgeInsets.all(14),
            ),
            child: const Icon(
              Icons.delete,
              color: Constants.white,
              size: 26,
            ),
          );
        }),
      ],
    );
    return Slidable(
        key: const ValueKey(0),
        startActionPane: endAction ? null : action,
        endActionPane: endAction ? action : null,
        child: widget);
  }
}
