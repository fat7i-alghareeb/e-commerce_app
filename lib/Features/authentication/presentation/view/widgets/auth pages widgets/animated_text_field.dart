import 'package:flutter/material.dart';

import 'custom_text_form_field.dart';

class AnimatedTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Animation<double> animation;
  final bool isValid;
  final String errorMessage;
  final IconData prefixIcon;

  const AnimatedTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    required this.animation,
    required this.isValid,
    required this.errorMessage,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 4),
            end: Offset.zero,
          ).animate(animation),
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
      },
      child: CustomTextFormField(
        controller: controller,
        obscureText: obscureText,
        prefixIcon: prefixIcon,
        isValid: isValid,
        hintText: hintText,
        errorMessage: errorMessage,
      ),
    );
  }
}
