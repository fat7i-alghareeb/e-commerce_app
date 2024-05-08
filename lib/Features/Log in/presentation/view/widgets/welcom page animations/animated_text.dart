import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    super.key,
    required Animation<double> animation,
    required this.text,
  }) : _animation = animation;

  final Animation<double> _animation;
  final Widget text;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
            left: 20,
            bottom: -80 + MediaQuery.of(context).size.height * _animation.value,
            child: text);
      },
    );
  }
}
