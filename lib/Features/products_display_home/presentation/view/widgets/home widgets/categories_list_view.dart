import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_app/utils/helper_extensions.dart';

import '../../../../../../utils/router/router_paths.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key, required this.categories});
  final List<List<String>> categories;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      itemCount: categories[0].length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              KRouter.categoryProducts,
              arguments: categories[0][index],
            );
            HapticFeedback.heavyImpact();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundColor: context.neutralColor(),
                  child: Image.asset(
                    categories[1][index],
                    height: 35,
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                child: Text(
                  textAlign: TextAlign.center,
                  categories[0][index],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
