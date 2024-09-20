import 'package:flutter/material.dart';
import '../../../../../../utils/helper_extensions.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.prefixIcon,
    required this.isValid,
    required this.hintText,
    required this.errorMessage,
    this.textInputType,
  });

  final TextEditingController controller;
  final bool obscureText;
  final IconData prefixIcon;
  final bool isValid;
  final String hintText;
  final String errorMessage;
  final TextInputType? textInputType;
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
      keyboardType: widget.textInputType,
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
                  _obscureText
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye,
                  size: 25,
                  color: _obscureText
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
