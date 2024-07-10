import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.widget,
    required this.onPressed,
  });
  final Widget widget;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const CircleBorder(),
      color: Theme.of(context).colorScheme.secondary,
      child: IconButton(
        onPressed: onPressed,
        icon: widget,
      ),
    );
  }
}
