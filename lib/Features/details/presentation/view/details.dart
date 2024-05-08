import 'package:flutter/material.dart';
import '../../../../utils/assets.dart';
import '../../../../shared/models/product.dart';
import '../../../../utils/constants.dart';
import 'widgets/details_body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen(
      {super.key, required this.product, required this.fromHome});
  final Product product;
  final bool fromHome;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: detailsAppBar(context),
      body: DetailsBody(product: product, fromHome: fromHome),
    );
  }

  AppBar detailsAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Theme.of(context).colorScheme.tertiary,
          size: 25,
        ),
      ),
      title: Image.asset(
        categoriesAvailable[product.category] ?? AssetsImages.electronics,
        height: 35,
        color: Theme.of(context).colorScheme.tertiary,
      ),
      elevation: 0,
    );
  }
}
