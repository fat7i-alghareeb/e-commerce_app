import 'package:flutter/material.dart';

class ShimmerWidget extends StatelessWidget {
  final List<double>? paddingLTRB;
  final double? hight;
  final double? width;
  final double? borderRadius;
  const ShimmerWidget({
    super.key,
    this.paddingLTRB,
    this.hight,
    this.width,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        paddingLTRB?[0] ?? 0,
        paddingLTRB?[1] ?? 0,
        paddingLTRB?[2] ?? 0,
        paddingLTRB?[3] ?? 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          color: Colors.grey[600]?.withOpacity(0.7),
        ),
        height: hight,
        width: width,
      ),
    );
  }
}
