import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableWidget extends StatelessWidget {
  final Function(BuildContext) deleteAction;
  final Function(BuildContext) confirmAction;
  final Widget child;
  const SlidableWidget({
    required this.child,
    required this.deleteAction,
    required this.confirmAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.7,
        children: [
          SlidableAction(
            onPressed: deleteAction,
            icon: Icons.delete,
            backgroundColor: Colors.red.shade300,
            borderRadius: BorderRadius.circular(20),
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: confirmAction,
            icon: Icons.check_circle_outline_rounded,
            backgroundColor: Colors.green,
            borderRadius: BorderRadius.circular(20),
            label: 'Confirm',
          ),
        ],
      ),
      child: child,
    );
  }
}
