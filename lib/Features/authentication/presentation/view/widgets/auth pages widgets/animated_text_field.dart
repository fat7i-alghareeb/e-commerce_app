import 'package:flutter/material.dart';
import 'package:store_app/utils/helper_extensions.dart';

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

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.prefixIcon,
    required this.isValid,
    required this.hintText,
    required this.errorMessage,
  });

  final TextEditingController controller;
  final bool obscureText;
  final IconData prefixIcon;
  final bool isValid;
  final String hintText;
  final String errorMessage;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;
  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      style: TextStyle(
        color: context.onPrimaryColor(),
      ),
      cursorColor: context.onPrimaryColor(),
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.prefixIcon,
          color: context.accentColor(),
        ),
        suffix: widget.obscureText
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  Icons.remove_red_eye,
                  size: 25,
                  color: widget.obscureText
                      ? context.onPrimaryColor().withOpacity(0.5)
                      : context.accentColor(),
                ),
              )
            : const SizedBox(height: 25),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isValid ? context.primaryColor() : Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isValid ? Colors.grey : Colors.red,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        filled: true,
        fillColor: context.neutralColor(),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: widget.isValid ? Colors.grey[500] : Colors.red,
        ),
        errorText: widget.isValid ? null : widget.errorMessage,
      ),
    );
  }
}
