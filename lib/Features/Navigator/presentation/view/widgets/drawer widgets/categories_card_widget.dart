import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../utils/router/router_paths.dart';

import '../../../../../../utils/constants.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({
    super.key,
    required this.name,
    required this.image,
    required this.isSelected,
    required this.index,
  });
  final String name;
  final String image;
  final bool isSelected;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (selectedIndex == index) {
          Scaffold.of(context).closeEndDrawer();
          HapticFeedback.heavyImpact();
        } else {
          Navigator.pushReplacementNamed(context, KRouter.categoryProducts,
              arguments: name);
          selectedIndex = index;
          HapticFeedback.heavyImpact();
        }
      },
      child: Card(
        color: isSelected
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.primary.withOpacity(0.8),
        shadowColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.tertiary,
        elevation: isSelected ? 4 : 2,
        //margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: isSelected ? 19 : 17,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.tertiary,
              ),
            ),
            trailing: Image.asset(
              image,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.tertiary,
              height: isSelected ? 28 : 25,
            ),
          ),
        ),
      ),
    );
  }
}
