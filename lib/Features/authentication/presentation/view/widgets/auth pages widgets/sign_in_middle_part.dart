import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../manger/signIn/sign_in_cubit.dart';
import '../../../../../../utils/helper_extensions.dart';

import '../../../../../../utils/functions/is_email_valid.dart';
import 'animated_text_field.dart';
import 'auth_button.dart';

class SignInMiddlePartUI extends StatefulWidget {
  const SignInMiddlePartUI({
    super.key,
    required this.animation,
    required this.pageController,
  });
  final Animation<double> animation;
  final PageController pageController;
  @override
  State<SignInMiddlePartUI> createState() => _SignInMiddlePartUIState();
}

class _SignInMiddlePartUIState extends State<SignInMiddlePartUI> {
  final gmailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userNameController = TextEditingController();
  late bool _isGmailValid;
  late bool _isPasswordValid;
  late bool _isUserNameValid;
  late bool _isConfirmPasswordController;
  late bool _isPasswordsFieldsMatched;

  @override
  void initState() {
    _isGmailValid = true;
    _isPasswordValid = true;
    _isUserNameValid = true;
    _isConfirmPasswordController = true;
    _isPasswordsFieldsMatched = true;
    super.initState();
  }

  bool _validateFields() {
    setState(() {
      _isGmailValid = isEmailValid(gmailController.text);
      _isPasswordValid = passwordController.text.isNotEmpty;
      _isConfirmPasswordController = passwordController.text.isNotEmpty;
      _isUserNameValid = userNameController.text.isNotEmpty;
      _isPasswordsFieldsMatched =
          passwordController.text == confirmPasswordController.text;
    });

    return _isUserNameValid &&
        _isGmailValid &&
        _isPasswordValid &&
        _isConfirmPasswordController &&
        _isPasswordsFieldsMatched;
  }

  @override
  void dispose() {
    gmailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedTextFormField(
          controller: userNameController,
          hintText: 'userName',
          animation: widget.animation,
          isValid: _isUserNameValid,
          errorMessage: "Please enter a value or put a valid Gmail",
          prefixIcon: Icons.person,
        ),
        ///////////////////////////////////////////////////////////////////////////////////////////
        const SizedBox(height: 10),
        ///////////////////////////////////////////////////////////////////////////////////////////
        AnimatedTextFormField(
          controller: gmailController,
          hintText: 'Gmail',
          animation: widget.animation,
          isValid: _isGmailValid,
          errorMessage: "Please enter a value or put a valid Gmail",
          prefixIcon: Icons.email,
        ),
        ///////////////////////////////////////////////////////////////////////////////////////////
        const SizedBox(height: 10),
        ///////////////////////////////////////////////////////////////////////////////////////////
        AnimatedTextFormField(
          controller: passwordController,
          hintText: 'Password',
          obscureText: true,
          animation: widget.animation,
          isValid: _isPasswordValid && _isPasswordsFieldsMatched,
          errorMessage: _isPasswordsFieldsMatched
              ? "Please enter a value"
              : "The password fields doesn't match",
          prefixIcon: Icons.lock,
        ),
        ///////////////////////////////////////////////////////////////////////////////////////////
        const SizedBox(height: 10),
        ///////////////////////////////////////////////////////////////////////////////////////////
        AnimatedTextFormField(
          controller: confirmPasswordController,
          hintText: 'Confirm password',
          obscureText: true,
          animation: widget.animation,
          isValid: _isConfirmPasswordController && _isPasswordsFieldsMatched,
          errorMessage: _isPasswordsFieldsMatched
              ? "Please enter a value"
              : "The password fields doesn't match",
          prefixIcon: Icons.lock,
        ),
        ///////////////////////////////////////////////////////////////////////////////////////////
        const SizedBox(height: 35),
        ///////////////////////////////////////////////////////////////////////////////////////////

        AuthButton(
          onTap: () async {
            if (_validateFields()) {
              FocusManager.instance.primaryFocus?.unfocus();
              context.read<SignInCubit>().createUserWithEmailAndPassword(
                    email: gmailController.text,
                    password: passwordController.text,
                    userName: userNameController.text,
                  );

              HapticFeedback.heavyImpact();
            }
          },
          animation: widget.animation,
          buttonName: "Create an account",
        ),
        ///////////////////////////////////////////////////////////////////////////////////////////
        const SizedBox(height: 20),
        ///////////////////////////////////////////////////////////////////////////////////////////

        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(4, 0),
            end: Offset.zero,
          ).animate(widget.animation),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account? ",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();
                  widget.pageController.jumpToPage(1);
                },
                child: Text(
                  "log in",
                  style: TextStyle(
                    fontSize: 18,
                    color: context.accentColor(),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
