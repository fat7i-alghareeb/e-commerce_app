import 'package:flutter/material.dart';

class SortTypeWidget extends StatelessWidget {
  const SortTypeWidget({
    super.key,
    required this.typeName,
    required this.isSelected,
  });
  final String typeName;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        color: isSelected
            ? Theme.of(context).colorScheme.secondary
            : Colors.grey[200],
      ),
      child: Center(
        child: Text(
          typeName,
        ),
      ),
    );
  }
}
