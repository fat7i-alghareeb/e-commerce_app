import 'package:flutter/material.dart';
import 'package:store_app/utils/helper_extensions.dart';

class AuthButton extends StatelessWidget {
  final Function()? onTap;
  final Animation<double> animation;
  final String buttonName;
  const AuthButton({
    super.key,
    required this.onTap,
    required this.animation,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(4, 0),
            end: Offset.zero,
          ).animate(animation),
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
          decoration: BoxDecoration(
            color: context.accentColor(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              buttonName,
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
