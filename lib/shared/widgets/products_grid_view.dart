import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_card.dart';
import 'shimmer.dart';

class ProductSliverGrid extends StatelessWidget {
  const ProductSliverGrid({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 25,
        crossAxisSpacing: 15,
        childAspectRatio: 0.52,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = products[index];
          return ProductCard(product: product);
        },
        childCount: products.length,
      ),
    );
  }
}

class ProductGridShimmerEffects extends StatelessWidget {
  const ProductGridShimmerEffects({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 25,
        crossAxisSpacing: 15,
        childAspectRatio: 0.55,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: 20,
        (context, index) => const ShimmerWidget(
          borderRadius: 15,
        ),
      ),
    );
  }
}
