import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/utils/helper_extensions.dart';

import '../../../../../shared/widgets/app_icon.dart';
import '../../../../../utils/assets.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: context.neutralColor(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Quantity",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: AppIcon(
                    widget: SvgPicture.asset(
                      AssetsImages.plus,
                      width: 15,
                      colorFilter: ColorFilter.mode(
                        context.primaryColor(),
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () {},
                    color: context.accentColor(),
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                const Text(
                  "1",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: AppIcon(
                    widget: SvgPicture.asset(
                      AssetsImages.minus,
                      width: 15,
                      colorFilter: ColorFilter.mode(
                        context.primaryColor(),
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () {},
                    color: context.accentColor(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
