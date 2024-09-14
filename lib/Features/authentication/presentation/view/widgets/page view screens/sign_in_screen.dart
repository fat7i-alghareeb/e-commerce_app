import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/authentication/presentation/manger/cubit/sign_in_cubit.dart';
import 'package:store_app/Features/authentication/presentation/manger/cubit/sign_in_state.dart';
import 'package:store_app/utils/functions/sign_in_indicator.dart';
import '../../../../../../utils/assets.dart';
import '../log in page animations/animated_text_field.dart';
import '../auth pages widgets/animated_bottom_part.dart';
import '../auth pages widgets/animated_divider.dart';
import '../auth pages widgets/auth_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, required this.pageController});
  final PageController pageController;
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _downAnimationController;
  late Animation<double> _downAnimation;
  late AnimationController _colorAnimationController;
  late Animation<int> _colorAnimation;

  final usernameController = TextEditingController();
  final gmailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isUsernameValid = true;
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

  bool _isEmailValid(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );
    return emailRegex.hasMatch(email);
  }

  bool _validateFields() {
    setState(() {
      _isUsernameValid = usernameController.text.isNotEmpty;
      _isGmailValid = _isEmailValid(gmailController.text);
      _isPasswordValid = passwordController.text.isNotEmpty;
    });

    return _isUsernameValid && _isGmailValid && _isPasswordValid;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInLoading) {
          signInLoadingIndicator(context: context, isLoading: true);
        } else if (state is SignInFailure) {
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
              AnimatedTextFormField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
                animation: _animation,
                isValid: _isUsernameValid,
                errorMessage: "Please enter a value",
              ),
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
                    FocusManager.instance.primaryFocus?.unfocus();
                    BlocProvider.of<SignInCubit>(context)
                        .createUserWithEmailAndPassword(
                      email: gmailController.text,
                      password: passwordController.text,
                      userName: usernameController.text,
                    );
                    // final mainScreen=Navigator.pushReplacementNamed(
                    //         context,
                    //         KRouter.mainNavigator,
                    //       );
                    // await BlocProvider.of<UserInfoCubit>(context)
                    //     .saveUser(
                    //       userName: usernameController.text,
                    //       gmail: gmailController.text,
                    //       password: passwordController.text,
                    //     )
                    //     .then(
                    //       (_) => mainScreen
                    //     );

                    HapticFeedback.heavyImpact();
                  }
                },
                animation: _animation,
              ),

              ///////////////////////////////////////////////////////////////////////////////////////////
              const SizedBox(height: 40),
              ///////////////////////////////////////////////////////////////////////////////////////////
              AnimatedDivider(colorAnimation: _colorAnimation),
              const SizedBox(height: 50),
              AnimatedBottomPart(
                downAnimation: _downAnimation,
                pageController: widget.pageController,
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
