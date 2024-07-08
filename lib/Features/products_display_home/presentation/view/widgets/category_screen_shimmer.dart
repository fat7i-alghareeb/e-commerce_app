import 'package:flutter/widgets.dart';

import '../../../../../shared/widgets/shimmer.dart';

class CategoryScreenShimmer extends StatelessWidget {
  const CategoryScreenShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ShimmerWidget(
                paddingLTRB: const [5, 0, 10, 5],
                hight: (MediaQuery.of(context).size.height * 0.3),
                width: (MediaQuery.of(context).size.width - 50) / 2,
                borderRadius: 11,
              ),
              ShimmerWidget(
                paddingLTRB: const [10, 0, 0, 5],
                hight: (MediaQuery.of(context).size.height * 0.3),
                width: (MediaQuery.of(context).size.width - 50) / 2,
                borderRadius: 11,
              ),
            ],
          ),
        );
      },
    );
  }
}
