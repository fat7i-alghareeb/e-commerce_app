import 'package:flutter/material.dart';
import 'package:store_app/utils/helper_extensions.dart';

class LogInButton extends StatelessWidget {
  final Function()? onTap;
  final Animation<double> animation;

  const LogInButton({super.key, required this.onTap, required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(400 * (1 - animation.value), 0),
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: context.accentColor(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              "Log in",
              style: TextStyle(
                color: context.primaryColor(),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
