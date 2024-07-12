import 'package:flutter/material.dart';
import '../../../../../shared/models/product.dart';
import '../../../../../shared/widgets/sliver_sized_box.dart';
import 'home widgets/categories_part_widget.dart';
import 'home widgets/home_upper_part.dart';
import '../../../../../shared/widgets/products_grid_view.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.products,
  });
  final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
        child: CustomScrollView(
          slivers: [
            const HomeUpperPart(),
            const SliverSizedBox(
              height: 20,
            ),
            const SliverToBoxAdapter(child: CategoriesPart()),
            const SliverSizedBox(
              height: 5,
            ),
            SliverToBoxAdapter(
              child: Text(
                "New In",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 30,
                  fontFamily: "caveat",
                  fontWeight: FontWeight.w900,
                  // fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SliverSizedBox(
              height: 20,
            ),
            ProductSliverGrid(
              products: products,
            ),
            const SliverSizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
