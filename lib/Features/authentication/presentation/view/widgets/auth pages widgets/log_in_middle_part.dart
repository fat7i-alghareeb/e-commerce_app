import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../manger/cubit/log_in_cubit.dart';
import '../../../../../../utils/helper_extensions.dart';
import '../../../../../../utils/functions/is_email_valid.dart';
import 'animated_text_field.dart';
import 'auth_button.dart';

class LogInMiddlePart extends StatefulWidget {
  const LogInMiddlePart(
      {super.key, required animation, required this.pageController})
      : _animation = animation;
  final Animation<double> _animation;
  final PageController pageController;
  @override
  State<LogInMiddlePart> createState() => _LogInMiddlePartState();
}

class _LogInMiddlePartState extends State<LogInMiddlePart> {
  final gmailController = TextEditingController();
  final passwordController = TextEditingController();

  late bool _isGmailValid;
  late bool _isPasswordValid;
  bool _sendPasswordReset = true;

  @override
  void initState() {
    _isGmailValid = true;
    _isPasswordValid = true;
    super.initState();
  }

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
          animation: widget._animation,
          isValid: _isGmailValid,
          errorMessage: "Please enter a value or put a valid Gmail",
          prefixIcon: Icons.email,
          textInputType: TextInputType.emailAddress,
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
          prefixIcon: Icons.lock,
        ),

        ///////////////////////////////////////////////////////////////////////////////////////////
        const SizedBox(height: 15),
        ///////////////////////////////////////////////////////////////////////////////////////////
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(4, 0),
            end: Offset.zero,
          ).animate(widget._animation),
          child: InkWell(
            onTap: () {
              HapticFeedback.heavyImpact();
              setState(() {
                _isGmailValid = isEmailValid(gmailController.text);
              });
              if (_isGmailValid && _sendPasswordReset) {
                context
                    .read<LogInCubit>()
                    .sendPasswordResetEmail(email: gmailController.text.trim());
                _sendPasswordReset = false;
              }
              Future.delayed(
                const Duration(seconds: 10),
                () => _sendPasswordReset = true,
              );
            },
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
              FocusManager.instance.primaryFocus?.unfocus();
              context.read<LogInCubit>().logInWithEmailAndPassword(
                    email: gmailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
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
              InkWell(
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
