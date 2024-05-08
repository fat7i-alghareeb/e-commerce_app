import 'package:flutter/material.dart';

import '../../../../../shared/models/product.dart';
import '../../../../../shared/widgets/app_image.dart';
import '../../../../../utils/assets.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/router/router_paths.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, KRouter.detailsScreen, arguments: {
          "fromHome": true,
          "product": product,
        });
      },
      child: Card(
        margin: const EdgeInsets.all(0),
        elevation: 8,
        color: Theme.of(context).colorScheme.primary,
        shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppImage(product: product),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 10),
              child: Image.asset(
                categoriesAvailable[product.category] ??
                    AssetsImages.electronics,
                height: 24,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 10),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                // softWrap: false,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 20, top: 10),
              child: Text(
                '\$${product.price} USD',
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  //fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
