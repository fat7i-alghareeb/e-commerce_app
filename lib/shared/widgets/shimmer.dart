import 'package:flutter/material.dart';

class ShimmerWidget extends StatelessWidget {
  final List<double> paddingLTRB;
  final double hight;
  final double width;
  final double borderRadius;
  const ShimmerWidget({
    super.key,
    required this.paddingLTRB,
    required this.hight,
    required this.width,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          paddingLTRB[0], paddingLTRB[1], paddingLTRB[2], paddingLTRB[3]),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.grey[600]?.withOpacity(0.7),
        ),
        height: hight,
        width: width,
      ),
    );
  }
}
