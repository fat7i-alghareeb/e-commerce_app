import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/authentication/presentation/manger/cubit/log_in_cubit.dart';
import 'package:store_app/utils/functions/sign_in_indicator.dart';
import 'package:store_app/utils/helper_extensions.dart';
import '../../../../../../utils/assets.dart';
import '../../../../../../utils/functions/is_email_valid.dart';
import '../log in page animations/animated_text_field.dart';
import '../auth pages widgets/animated_bottom_part.dart';
import '../auth pages widgets/animated_divider.dart';
import '../auth pages widgets/auth_button.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key, required this.pageController});
  final PageController pageController;
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _downAnimationController;
  late Animation<double> _downAnimation;
  late AnimationController _colorAnimationController;
  late Animation<int> _colorAnimation;

  final gmailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isGmailValid = true;
  bool _isPasswordValid = true;
  @override
  void initState() {
    super.initState();
    initAnimations();
  }

//todo solve the focus problem when keyboard closed
  @override
  void dispose() {
    _controller.dispose();
    _downAnimationController.dispose();
    _colorAnimationController.dispose();
    gmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _validateFields() {
    setState(() {
      _isGmailValid = isEmailValid(gmailController.text);
      _isPasswordValid = passwordController.text.isNotEmpty;
    });

    return _isGmailValid && _isPasswordValid;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogInCubit, LogInState>(
      listener: (context, state) {
        if (state is LogInLoading) {
          signInLoadingIndicator(context: context, isLoading: true);
        } else if (state is LogInFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 2),
              content: Text(state.message),
              backgroundColor: Colors.red[700],
              padding: const EdgeInsets.all(25),
            ),
          );
          signInLoadingIndicator(context: context, isLoading: false);
        } else {
          signInLoadingIndicator(context: context, isLoading: false);
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(_animation),
                child: Image.asset(
                  AssetsImages.storeLogo,
                  height: 150,
                ),
              ),
              ///////////////////////////////////////////////////////////////////////////////////////////
              const SizedBox(height: 50),

              ///////////////////////////////////////////////////////////////////////////////////////////
              const SizedBox(height: 10),
              ///////////////////////////////////////////////////////////////////////////////////////////
              AnimatedTextFormField(
                controller: gmailController,
                hintText: 'Gmail',
                obscureText: false,
                animation: _animation,
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
                animation: _animation,
                isValid: _isPasswordValid,
                errorMessage: "Please enter a value",
              ),
              ///////////////////////////////////////////////////////////////////////////////////////////
              const SizedBox(height: 35),
              ///////////////////////////////////////////////////////////////////////////////////////////

              AuthButton(
                onTap: () async {
                  if (_validateFields()) {
                    HapticFeedback.heavyImpact();
                  }
                },
                animation: _animation,
                buttonName: "Log in",
              ),
              ///////////////////////////////////////////////////////////////////////////////////////////
              const SizedBox(height: 20),
              ///////////////////////////////////////////////////////////////////////////////////////////

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => widget.pageController.jumpToPage(2),
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

              ///////////////////////////////////////////////////////////////////////////////////////////
              const SizedBox(height: 40),
              ///////////////////////////////////////////////////////////////////////////////////////////
              AnimatedDivider(colorAnimation: _colorAnimation),
              const SizedBox(height: 50),
              AnimatedBottomPart(
                downAnimation: _downAnimation,
              ),
              //////////////////////////////////////////////////////////////////////////////////////////////
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  void initAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
/////////////////////////////////////////////////////////////////////////
    _downAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _downAnimation = CurvedAnimation(
      parent: _downAnimationController,
      curve: Curves.easeInOut,
    );
/////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////
    _colorAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _colorAnimation =
        IntTween(begin: 0, end: 255).animate(_colorAnimationController);
/////////////////////////////////////////////////////////////////////////
    _controller.forward().then((_) {
      _downAnimationController.forward();
      _colorAnimationController.forward();
    });
  }
}
