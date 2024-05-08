import 'package:flutter/material.dart';

import '../../../../../shared/widgets/shimmer.dart';

class MainScreenShimmer extends StatelessWidget {
  const MainScreenShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerWidget(
          paddingLTRB: const [0, 0, 0, 0],
          hight: MediaQuery.of(context).size.height * 0.47,
          width: double.infinity,
          borderRadius: 30,
        ),
        const ShimmerWidget(
          paddingLTRB: [17, 27, 30, 0],
          hight: 20,
          width: 160,
          borderRadius: 0,
        ),
        Expanded(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    ShimmerWidget(
                      paddingLTRB: const [5, 5, 10, 5],
                      hight: (MediaQuery.of(context).size.height * 0.3),
                      width: (MediaQuery.of(context).size.width - 50) / 2,
                      borderRadius: 11,
                    ),
                    ShimmerWidget(
                      paddingLTRB: const [10, 5, 0, 5],
                      hight: (MediaQuery.of(context).size.height * 0.3),
                      width: (MediaQuery.of(context).size.width - 50) / 2,
                      borderRadius: 11,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
