import 'package:flutter/material.dart';
import 'cached_image.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.image,
    this.alignment,
    required this.id,
  });

  final String image;
  final int id;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 2,
      child: Hero(
        tag: id,
        child: CachedImage(
          url: image,
          boxFit: BoxFit.cover,
          alignment: alignment,
        ),
      ),
    );
  }
}
