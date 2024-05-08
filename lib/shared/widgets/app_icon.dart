import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.widget,
    required this.onPressed,
    required this.opacity,
  });
  final Widget widget;
  final void Function() onPressed;
  final double opacity;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary.withOpacity(.15),
      child: IconButton(
        onPressed: onPressed,
        icon: widget,
      ),
    );
  }
}
