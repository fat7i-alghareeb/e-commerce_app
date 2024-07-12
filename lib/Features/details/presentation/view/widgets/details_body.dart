import 'package:flutter/material.dart';
import '../../../../../shared/widgets/sliver_sized_box.dart';
import '../../../../../shared/models/product.dart';
import 'add_to_cart.dart';
import 'product_main_details_widget.dart';
import 'product_sub_details.dart';
import 'quantity_widget.dart';
import 'reviews_widget.dart';

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
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: ProductMainDetailsWidget(product: product),
                    ),
                    const SliverSizedBox(
                      height: 34,
                    ),
                    const SliverToBoxAdapter(child: QuantityWidget()),
                    const SliverSizedBox(
                      height: 24,
                    ),
                    SliverToBoxAdapter(
                      child: ProductSubDetailsWidget(product: product),
                    ),
                    const SliverSizedBox(
                      height: 10,
                    ),
                    ReviewsWidget(reviews: product.reviews!),
                    const SliverSizedBox(
                      height: 100,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AddToCartWidget(product: product, fromHome: fromHome),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
