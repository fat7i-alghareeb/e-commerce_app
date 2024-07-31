import 'package:flutter/material.dart';
import 'package:store_app/utils/helper_extensions.dart';
import '../../../../../shared/models/product.dart';
import 'details_sub_titles.dart';
import 'details_titles.dart';

class ProductSubDetailsWidget extends StatelessWidget {
  const ProductSubDetailsWidget({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DetailsSubTitlesWidget(text: product.description),
        const SizedBox(
          height: 26,
        ),
        const DetailsTitleWidget(
          text: "Shipping",
        ),
        const SizedBox(
          height: 16,
        ),
        DetailsSubTitlesWidget(
          text:
              product.shippingInformation ?? "There's no information available",
        ),
        const SizedBox(
          height: 26,
        ),
        const DetailsTitleWidget(
          text: "Returns",
        ),
        const SizedBox(
          height: 16,
        ),
        DetailsSubTitlesWidget(
          text: product.returnPolicy ?? "There's no information available",
        ),
        const SizedBox(
          height: 26,
        ),
        const DetailsTitleWidget(
          text: "Reviews",
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "${product.rating?.toStringAsFixed(1) ?? "No "} Ratings",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        DetailsSubTitlesWidget(
          text: "${product.reviews?.length ?? "0"} Reviews",
        ),
        const SizedBox(height: 5),
        Divider(
          color: context.neutralColor(),
          thickness: 3,
        ),
      ],
    );
  }
}
