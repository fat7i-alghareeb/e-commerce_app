import 'package:flutter/material.dart';

import '../clipper.dart';

class AnimatedClipPath extends StatelessWidget {
  const AnimatedClipPath({
    super.key,
    required Animation<double> clipperAnimation,
    required this.color,
  }) : _clipperAnimation = clipperAnimation;

  final Animation<double> _clipperAnimation;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _clipperAnimation,
      builder: (context, child) {
        return ClipPath(
          clipper: Clipper(),
          child: Container(
            color: color,
            height:
                MediaQuery.of(context).size.height * _clipperAnimation.value,
          ),
        );
      },
    );
  }
}
