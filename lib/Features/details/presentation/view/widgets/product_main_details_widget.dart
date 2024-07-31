import 'package:flutter/material.dart';
import 'package:store_app/utils/helper_extensions.dart';

import '../../../../../shared/models/product.dart';
import '../../../../../utils/assets.dart';
import '../../../../../utils/constants.dart';
import 'details_app_bar.dart';
import 'images_slide_show.dart';

class ProductMainDetailsWidget extends StatelessWidget {
  const ProductMainDetailsWidget({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
          child: DetailsAppBar(
            image:
                categoriesAvailable[product.category] ?? AssetsImages.groceries,
          ),
        ),
        SizedBox(
          height: 270,
          child: ImagesSlideshow(
            images: product.images,
            tag: product.id,
          ),
        ),
        const SizedBox(
          height: 22,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            product.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            "\$${product.price}",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: context.accentColor(),
            ),
          ),
        ),
      ],
    );
  }
}
