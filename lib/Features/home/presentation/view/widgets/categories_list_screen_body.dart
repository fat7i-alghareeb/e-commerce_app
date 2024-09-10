import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/utils/helper_extensions.dart';

import '../../../../../shared/widgets/app_icon.dart';
import '../../../../../shared/widgets/sliver_sized_box.dart';
import '../../../../../utils/assets.dart';
import '../../../../Navigator/presentation/view/widgets/drawer widgets/categories_card_widget.dart';

class CategoriesListBody extends StatelessWidget {
  const CategoriesListBody({
    super.key,
    required this.categories,
  });

  final List<List<String>> categories;

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
                    colorFilter: ColorFilter.mode(
                      context.onPrimaryColor(),
                      BlendMode.srcIn,
                    ),
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
          const SliverToBoxAdapter(
            child: Text(
              "Shop by Categories",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
          ),
          const SliverSizedBox(
            height: 20,
          ),
          SliverList.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CategoriesCard(
                  name: categories[0][index],
                  image: categories[1][index],
                ),
              );
            },
            itemCount: categories[0].length,
          ),
          const SliverSizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
