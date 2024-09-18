import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../../utils/helper_extensions.dart';

import '../../../../../../utils/router/router_paths.dart';

class CategoriesCard extends StatelessWidget {
  const CategoriesCard({
    super.key,
    required this.name,
    required this.image,
  });
  final String name;
  final String image;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          KRouter.categoryProducts,
          arguments: name,
        );
        HapticFeedback.heavyImpact();
      },
      child: Card(
        color: context.neutralColor().withOpacity(0.8),
        shadowColor: context.accentColor().withOpacity(.05),
        elevation: 2,
        margin: EdgeInsets.zero,
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: Image.asset(
            image,
            height: 25,
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
