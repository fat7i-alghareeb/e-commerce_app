import 'package:flutter/material.dart';

import '../../../../../shared/models/product.dart';
import '../../../../../shared/widgets/app_image.dart';
import 'add_to_cart.dart';
import 'key_card.dart';
import 'value_card.dart';

class DetailsBody extends StatelessWidget {
  const DetailsBody({
    super.key,
    required this.product,
    required this.fromHome,
  });

  final Product product;
  final bool fromHome;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15, top: 10),
                        child: AppImage(
                          product: product,
                        ),
                      ),
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 26,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const KeyCard(name: "Price:"),
                      ValueCard(info: "\$ ${product.price}"),
                      const KeyCard(name: "Details:"),
                      ValueCard(info: product.description),
                      const SizedBox(height: 150),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AddToCartWidget(product: product, fromHome: fromHome),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
