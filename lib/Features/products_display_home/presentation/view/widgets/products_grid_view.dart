import 'package:flutter/material.dart';
import '../../../../../shared/models/product.dart';
import 'product_card.dart';

class ProductsGridView extends StatelessWidget {
  final List<Product> products;
  final bool isScrollable;
  const ProductsGridView({
    super.key,
    required this.products,
    required this.isScrollable,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: isScrollable
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 25,
        crossAxisSpacing: 25,
        childAspectRatio: 0.6,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
        );
      },
    );
  }
}
