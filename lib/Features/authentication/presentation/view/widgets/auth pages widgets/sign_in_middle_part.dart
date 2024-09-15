import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/authentication/presentation/manger/signIn/sign_in_cubit.dart';
import 'package:store_app/utils/helper_extensions.dart';

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
  final userNameController = TextEditingController();
  bool _isGmailValid = true;
  bool _isPasswordValid = true;
  bool _isUserNameValid = true;

  bool _validateFields() {
    setState(() {
      _isGmailValid = isEmailValid(gmailController.text);
      _isPasswordValid = passwordController.text.isNotEmpty;
      _isUserNameValid = userNameController.text.isNotEmpty;
    });

    return _isUserNameValid && _isGmailValid && _isPasswordValid;
  }

  @override
  void dispose() {
    gmailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedTextFormField(
          controller: userNameController,
          hintText: 'userName',
          obscureText: false,
          animation: widget.animation,
          isValid: _isUserNameValid,
          errorMessage: "Please enter a value or put a valid Gmail",
        ),
        ///////////////////////////////////////////////////////////////////////////////////////////
        const SizedBox(height: 10),
        ///////////////////////////////////////////////////////////////////////////////////////////
        AnimatedTextFormField(
          controller: gmailController,
          hintText: 'Gmail',
          obscureText: false,
          animation: widget.animation,
          isValid: _isGmailValid,
          errorMessage: "Please enter a value or put a valid Gmail",
        ),
        ///////////////////////////////////////////////////////////////////////////////////////////
        const SizedBox(height: 10),
        ///////////////////////////////////////////////////////////////////////////////////////////
        AnimatedTextFormField(
          controller: passwordController,
          hintText: 'Password',
          obscureText: true,
          animation: widget.animation,
          isValid: _isPasswordValid,
          errorMessage: "Please enter a value",
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
