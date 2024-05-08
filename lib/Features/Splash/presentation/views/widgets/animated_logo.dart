import 'package:flutter/material.dart';

import '../../../../../utils/assets.dart';

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({
    super.key,
    required this.imageAnimation,
  });

  final Animation<double> imageAnimation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: imageAnimation,
        builder: (context, child) => ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.asset(
            AssetsImages.storeLogo,
            height: imageAnimation.value,
          ),
        ),
      ),
    );
  }
}
