import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store_app/Features/authentication/presentation/view/widgets/auth%20pages%20widgets/auth_button.dart';
import 'package:store_app/utils/functions/custom_snake_bar.dart';
import 'package:store_app/utils/helper_extensions.dart';
import 'package:store_app/utils/router/router_paths.dart';
import '../../../../utils/functions/formatted_time_from_Int.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    initAnimations();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -4),
                        end: Offset.zero,
                      ).animate(_animation),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Verification",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: context.accentColor(),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "We have sent you a verification link.\nPlease check your emails and verify your account.",
                            style: TextStyle(
                              fontSize: 18,
                              color: context.onPrimaryColor().withOpacity(0.5),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    VerificationButton(animation: _animation),
                  ],
                ),
              ),
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
    _controller.forward();
  }
}

class VerificationButton extends StatefulWidget {
  const VerificationButton({super.key, required this.animation});
  final Animation<double> animation;

  @override
  State<VerificationButton> createState() => _VerificationButtonState();
}

class _VerificationButtonState extends State<VerificationButton> {
  Timer? timer;
  Timer? resendTimer;
  int _resendTimer = 120;
  bool _canResendEmail = false;
  bool _isEmailVerified = false;

  Future<void> checkVerification() async {
    final user = FirebaseAuth.instance.currentUser;

    await user!.reload();

    _isEmailVerified = user.emailVerified;

    if (_isEmailVerified) {
      setState(() {
        timer?.cancel();
      });
    }
  }

  Future<void> sendVerificationEmail() async {
    if (!_canResendEmail) return;

    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();

      if (!mounted) return;

      startResendTimer();
    } catch (e) {
      if (!mounted) return;

      customSnakeBar(
        context: context,
        text: e.toString(),
        color: Colors.red,
      );
    }
  }

  void startResendTimer() {
    setState(() {
      _canResendEmail = false;
      _resendTimer = 120;
    });

    resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendTimer > 0) {
          _resendTimer--;
        } else {
          _canResendEmail = true;
          timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    if (!_isEmailVerified) {
      timer = Timer.periodic(
        const Duration(seconds: 3),
        (timer) => checkVerification(),
      );
    }
    startResendTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    resendTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      onTap: () async {
        if (_isEmailVerified) {
          if (!mounted) return;

          Navigator.pushReplacementNamed(
            context,
            KRouter.mainNavigator,
          );
        } else if (_canResendEmail) {
          await sendVerificationEmail();
        }
      },
      animation: widget.animation,
      color: _isEmailVerified ? Colors.green[700] : context.accentColor(),
      buttonName: _isEmailVerified
          ? "Done!"
          : _canResendEmail
              ? "Resend email"
              : "Resend in ${getFormattedTimeFromAnInt(_resendTimer)}",
    );
  }
}
