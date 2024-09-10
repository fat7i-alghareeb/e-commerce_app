import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/authentication/presentation/manger/cubit/sign_in_cubit.dart';
import 'package:store_app/Features/authentication/presentation/manger/cubit/sign_in_state.dart';
import 'package:store_app/utils/helper_extensions.dart';
import '../../../../../../shared/cubits/cubit/user_info_cubit.dart';
import '../../../../../../utils/assets.dart';
import '../../../../../../utils/router/router_paths.dart';
import '../log in page animations/animated_text_field.dart';
import '../log in page widgets/log_in_button.dart';
import '../log in page widgets/other_method_auth_widget.dart';

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
    return SafeArea(
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
            BlocBuilder<SignInCubit, SignInState>(
              builder: (context, state) {
                if (state is SignInInitial) {
                  return LogInButton(
                    onTap: () async {
                      if (_validateFields()) {
                        BlocProvider.of<SignInCubit>(context)
                            .createUserWithEmailAndPassword(
                          email: gmailController.text,
                          password: passwordController.text,
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
                  );
                } else if (state is SighInLoading) {
                  return const CircularProgressIndicator(
                    color: Colors.amber,
                  );
                } else if (state is SignInSuccess) {
                  return Text(
                      "${state.userEntity.email}     +     ${state.userEntity.uId}");
                } else if (state is SignInFailure) {
                  return Text(state.message);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            ///////////////////////////////////////////////////////////////////////////////////////////
            const SizedBox(height: 40),
            ///////////////////////////////////////////////////////////////////////////////////////////
            AnimatedDivider(colorAnimation: _colorAnimation),
            const SizedBox(height: 50),
            AnimatedBottomPart(downAnimation: _downAnimation, widget: widget),
            //////////////////////////////////////////////////////////////////////////////////////////////
            const SizedBox(height: 50),
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

class AnimatedBottomPart extends StatelessWidget {
  const AnimatedBottomPart({
    super.key,
    required Animation<double> downAnimation,
    required this.widget,
  }) : _downAnimation = downAnimation;

  final Animation<double> _downAnimation;
  final LoginPage widget;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 3),
        end: Offset.zero,
      ).animate(_downAnimation),
      child: AnimatedBuilder(
        animation: _downAnimation,
        builder: (context, child) => Opacity(
          opacity: _downAnimation.value,
          child: Stack(
            children: [
              const Center(
                child: OtherMethodAuthWidget(
                  imagePath: AssetsImages.google,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                child: SizedBox(
                  height: 50,
                  child: Card(
                    color: context.accentColor(),
                    margin: EdgeInsets.zero,
                    child: IconButton(
                      onPressed: () {
                        widget.pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                        HapticFeedback.heavyImpact();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: context.primaryColor(),
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedDivider extends StatelessWidget {
  const AnimatedDivider({
    super.key,
    required Animation<int> colorAnimation,
  }) : _colorAnimation = colorAnimation;

  final Animation<int> _colorAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) => Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Color.fromRGBO(189, 189, 189, _colorAnimation.value / 255),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Opacity(
              opacity: _colorAnimation.value / 255,
              child: Text(
                'Or continue with',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Color.fromRGBO(189, 189, 189, _colorAnimation.value / 255),
            ),
          ),
        ],
      ),
    );
  }
}
