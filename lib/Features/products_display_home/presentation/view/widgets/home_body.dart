import 'package:flutter/material.dart';
import '../../../../../shared/models/product.dart';
import 'home_upper_part.dart';
import 'products_grid_view.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.products,
  });
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final count = products.length >= 30 ? 15 : (products.length + 1) / 2;
    double grideHeight = (width * 0.8) * count;
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: grideHeight + 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeUpperPart(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "New Products",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: grideHeight,
                    child: ProductsGridView(
                      products: products,
                      isScrollable: false,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
