import 'package:flutter/material.dart';
import '../../../../../../utils/assets.dart';
import 'other_method_auth_widget.dart';

class AnimatedBottomPart extends StatelessWidget {
  const AnimatedBottomPart({
    super.key,
    required Animation<double> downAnimation,
  }) : _downAnimation = downAnimation;

  final Animation<double> _downAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 3),
        end: Offset.zero,
      ).animate(_downAnimation),
      child: AnimatedBuilder(
        animation: _downAnimation,
        builder: (context, child) => Opacity(
          opacity: _downAnimation.value,
          child: const Center(
            child: OtherMethodAuthWidget(
              imagePath: AssetsImages.google,
            ),
          ),
        ),
      ),
    );
  }
}
