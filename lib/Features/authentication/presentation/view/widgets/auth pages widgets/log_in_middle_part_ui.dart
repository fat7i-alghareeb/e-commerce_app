import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_app/utils/helper_extensions.dart';

import '../../../../../../utils/functions/is_email_valid.dart';
import 'animated_text_field.dart';
import 'auth_button.dart';

class LogInMiddlePartUI extends StatefulWidget {
  const LogInMiddlePartUI(
      {super.key, required animation, required this.pageController})
      : _animation = animation;
  final Animation<double> _animation;
  final PageController pageController;
  @override
  State<LogInMiddlePartUI> createState() => _LogInMiddlePartUIState();
}

class _LogInMiddlePartUIState extends State<LogInMiddlePartUI> {
  final gmailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isGmailValid = true;
  bool _isPasswordValid = true;

  bool _validateFields() {
    setState(() {
      _isGmailValid = isEmailValid(gmailController.text);
      _isPasswordValid = passwordController.text.isNotEmpty;
    });

    return _isGmailValid && _isPasswordValid;
  }

  @override
  void dispose() {
    gmailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AnimatedTextFormField(
          controller: gmailController,
          hintText: 'Gmail',
          obscureText: false,
          animation: widget._animation,
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
          animation: widget._animation,
          isValid: _isPasswordValid,
          errorMessage: "Please enter a value",
        ),

        ///////////////////////////////////////////////////////////////////////////////////////////
        const SizedBox(height: 15),
        ///////////////////////////////////////////////////////////////////////////////////////////
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(4, 0),
            end: Offset.zero,
          ).animate(widget._animation),
          child: GestureDetector(
            child: Text(
              "Forget password?",
              style: TextStyle(
                fontSize: 18,
                color: context.accentColor(),
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
        ///////////////////////////////////////////////////////////////////////////////////////////
        const SizedBox(height: 20),
        ///////////////////////////////////////////////////////////////////////////////////////////

        AuthButton(
          onTap: () async {
            if (_validateFields()) {
              HapticFeedback.heavyImpact();
            }
          },
          animation: widget._animation,
          buttonName: "Log in",
        ),
        ///////////////////////////////////////////////////////////////////////////////////////////
        const SizedBox(height: 20),
        ///////////////////////////////////////////////////////////////////////////////////////////

        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(4, 0),
            end: Offset.zero,
          ).animate(widget._animation),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.heavyImpact();

                  widget.pageController.jumpToPage(2);
                },
                child: Text(
                  "sign in",
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
