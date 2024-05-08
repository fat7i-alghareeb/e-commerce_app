import 'package:flutter/material.dart';

import '../models/product.dart';
import 'cached_image.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.5 / 2,
      child: Hero(
        tag: product.id,
        child: CachedImage(
          url: product.image,
          boxFit: BoxFit.contain,
        ),
      ),
    );
  }
}
