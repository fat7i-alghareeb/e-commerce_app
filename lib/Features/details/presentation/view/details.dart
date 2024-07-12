import 'package:flutter/material.dart';

import '../../../../shared/models/product.dart';
import 'widgets/details_body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen(
      {super.key, required this.product, required this.fromHome});
  final Product product;
  final bool fromHome;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DetailsBody(product: product, fromHome: fromHome),
    );
  }
}
