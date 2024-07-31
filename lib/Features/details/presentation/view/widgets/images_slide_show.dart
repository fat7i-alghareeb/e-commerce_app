import 'package:flutter/material.dart';
import 'package:store_app/utils/helper_extensions.dart';

import '../../../../../shared/widgets/cached_image.dart';

class ImagesSlideshow extends StatelessWidget {
  const ImagesSlideshow({super.key, required this.images, required this.tag});
  final List<String> images;
  final int tag;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 24),
      itemCount: images.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(
          right: 15,
        ),
        child: AspectRatio(
          aspectRatio: 0.55,
          child: Card(
            margin: EdgeInsets.zero,
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            elevation: 0.5,
            child: Container(
              color: context.neutralColor(),
              child: Hero(
                tag: index == 0 ? tag : index,
                child: CachedImage(
                  url: images[index],
                  boxFit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
