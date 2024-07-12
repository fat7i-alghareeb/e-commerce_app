import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../shared/models/product.dart';
import '../../../../../shared/widgets/app_icon.dart';
import '../../../../../shared/widgets/products_grid_view.dart';
import '../../../../../shared/widgets/sliver_sized_box.dart';
import '../../../../../utils/assets.dart';

class CategoryProductsBody extends StatelessWidget {
  const CategoryProductsBody({
    super.key,
    required this.categoryName,
    required this.products,
  });

  final String categoryName;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 20),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 53,
                width: 53,
                child: AppIcon(
                  widget: SvgPicture.asset(
                    AssetsImages.backArrow,
                    width: 10,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    HapticFeedback.heavyImpact();
                  },
                ),
              ),
            ),
          ),
          const SliverSizedBox(
            height: 20,
          ),
          SliverToBoxAdapter(
            child: Text(
              "$categoryName (${products.length})",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SliverSizedBox(
            height: 20,
          ),
          ProductSliverGrid(products: products),
          const SliverSizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
