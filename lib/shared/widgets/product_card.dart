import 'package:flutter/material.dart';

import '../../utils/router/router_paths.dart';
import '../models/product.dart';
import 'app_image.dart';

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
        elevation: 2,
        color: Theme.of(context).colorScheme.tertiary,
        shadowColor: Theme.of(context).colorScheme.secondary.withOpacity(.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppImage(
                image: product.thumbnail,
                id: product.id,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 15, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '\$${product.price} USD',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
