import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../shared/cubits/cubit/user_info_cubit.dart';
import '../../../../../../utils/assets.dart';
import '../../../../../../utils/router/router_paths.dart';
import '../log in page animations/animated_divider_and_image.dart';
import '../log in page animations/animated_text_field.dart';
import '../log in page widgets/log_in_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.pageController});
  final PageController pageController;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _downAnimationController;
  late Animation<double> _downAnimation;
  late AnimationController _dividerAnimationController;
  late Animation<double> _dividerAnimation;
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

  @override
  void dispose() {
    _controller.dispose();
    _downAnimationController.dispose();
    _dividerAnimationController.dispose();
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, -1),
                    end: Offset.zero,
                  ).animate(_animation),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      AssetsImages.storeLogo,
                      height: 200,
                    ),
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
                LogInButton(
                  onTap: () async {
                    if (_validateFields()) {
                      await BlocProvider.of<UserInfoCubit>(context)
                          .saveUser(
                            userName: usernameController.text,
                            gmail: gmailController.text,
                            password: passwordController.text,
                          )
                          .then(
                            (_) => Navigator.pushReplacementNamed(
                              context,
                              KRouter.mainNavigator,
                            ),
                          );

                      HapticFeedback.heavyImpact();
                    }
                  },
                  animation: _animation,
                ),
///////////////////////////////////////////////////////////////////////////////////////////
                const SizedBox(height: 40),
///////////////////////////////////////////////////////////////////////////////////////////
                AnimatedDividerAndImage(
                  dividerAnimation: _dividerAnimation,
                  imageAnimation: _downAnimation,
                  colorAnimation: _colorAnimation,
                  pageController: widget.pageController,
                ),
///////////////////////////////////////////////////////////////////////////////////////////
                const SizedBox(height: 50),
              ],
            ),
          ],
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
      duration: const Duration(milliseconds: 500),
    );
    _downAnimation = CurvedAnimation(
      parent: _downAnimationController,
      curve: Curves.easeInOut,
    );
/////////////////////////////////////////////////////////////////////////
    _dividerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _dividerAnimation = CurvedAnimation(
      parent: _dividerAnimationController,
      curve: Curves.easeInOut,
    );
/////////////////////////////////////////////////////////////////////////
    _colorAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _colorAnimation =
        IntTween(begin: 0, end: 255).animate(_colorAnimationController);
/////////////////////////////////////////////////////////////////////////
    _controller.forward().then((_) {
      _downAnimationController.forward();
      _colorAnimationController.forward();
      _dividerAnimationController.forward();
    });
  }
}
