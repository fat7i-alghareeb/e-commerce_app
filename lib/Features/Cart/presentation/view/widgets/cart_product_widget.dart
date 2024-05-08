import '../../../../../shared/widgets/app_image.dart';

import '../../../../../utils/router/router_paths.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/assets.dart';

import '../../../../../utils/constants.dart';
import '../../../../../shared/models/product.dart';

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, KRouter.detailsScreen, arguments: {
          "fromHome": false,
          "product": product,
        });
      },
      child: Card(
        color: Theme.of(context).colorScheme.primary.withOpacity(1),
        elevation: 5,
        margin: EdgeInsets.zero,
        child: SizedBox(
          height: 140,
          child: Row(
            children: [
              AppImage(product: product),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8, right: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        //softWrap: false,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        '\$${product.price} USD',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          //fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Image.asset(
                        categoriesAvailable[product.category] ??
                            AssetsImages.electronics,
                        height: 24,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
