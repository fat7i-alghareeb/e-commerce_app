import 'package:flutter/material.dart';

class ValueCard extends StatelessWidget {
  const ValueCard({
    super.key,
    required this.info,
  });

  final String info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 4,
        color: Theme.of(context).colorScheme.primary,
        shadowColor: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            info,
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}
