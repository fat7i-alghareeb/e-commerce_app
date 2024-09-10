import 'package:flutter/material.dart';

import '../../../../../../shared/widgets/products_grid_view.dart';
import '../../../../../../shared/widgets/shimmer.dart';

class MainScreenShimmer extends StatelessWidget {
  const MainScreenShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerWidget(
                        hight: 50,
                        width: 50,
                        borderRadius: 30,
                      ),
                      ShimmerWidget(
                        hight: 50,
                        width: 50,
                        borderRadius: 30,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const ShimmerWidget(
                    hight: 45,
                    borderRadius: 32,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const ShimmerWidget(
                    width: 150,
                    hight: 30,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  categoriesShimmerPart(),
                  const SizedBox(
                    child: ShimmerWidget(
                      width: 100,
                      hight: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const ProductGridShimmerEffects()
          ],
        ),
      ),
    );
  }

  SizedBox categoriesShimmerPart() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShimmerWidget(
                  borderRadius: 40,
                  width: 50,
                  hight: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                ShimmerWidget(
                  hight: 20,
                  width: 50,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
