import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../shared/widgets/app_icon.dart';
import '../../../../../utils/assets.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: AppIcon(
            onPressed: () {
              Navigator.pop(context);
              HapticFeedback.heavyImpact();
            },
            widget: SvgPicture.asset(
              AssetsImages.backArrow,
              width: 10,
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 50,
          child: AppIcon(
            onPressed: () {},
            widget: Image.asset(image),
          ),
        ),
      ],
    );
  }
}
