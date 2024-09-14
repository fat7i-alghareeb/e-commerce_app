import 'package:flutter/material.dart';

class AnimatedDivider extends StatelessWidget {
  const AnimatedDivider({
    super.key,
    required Animation<int> colorAnimation,
  }) : _colorAnimation = colorAnimation;

  final Animation<int> _colorAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) => Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Color.fromRGBO(189, 189, 189, _colorAnimation.value / 255),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Opacity(
              opacity: _colorAnimation.value / 255,
              child: Text(
                'Or continue with',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Color.fromRGBO(189, 189, 189, _colorAnimation.value / 255),
            ),
          ),
        ],
      ),
    );
  }
}
