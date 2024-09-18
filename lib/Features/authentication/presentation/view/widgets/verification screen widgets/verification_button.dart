import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../utils/helper_extensions.dart';
import '../../../../../../utils/functions/custom_snake_bar.dart';
import '../../../../../../utils/functions/formatted_time_from_Int.dart';
import '../../../../../../utils/router/router_paths.dart';
import '../../../manger/signIn/sign_in_cubit.dart';
import '../../../manger/signIn/sign_in_state.dart';
import '../auth pages widgets/auth_button.dart';

class VerificationButton extends StatefulWidget {
  const VerificationButton({super.key, required this.animation});
  final Animation<double> animation;

  @override
  State<VerificationButton> createState() => _VerificationButtonState();
}

class _VerificationButtonState extends State<VerificationButton> {
  Timer? timer;
  Timer? resendTimer;
  int _resendTimer = 60;
  bool _canResendEmail = false;
  bool _isEmailVerified = false;

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
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInEmailVerificationSuccess) {
          customSnakeBar(
            context: context,
            text: "Verification email sent!",
            color: Colors.green,
          );
        } else if (state is SignInEmailVerificationFailure) {
          customSnakeBar(
            context: context,
            text: state.message,
            color: Colors.red,
          );
        }
      },
      child: AuthButton(
        onTap: () async {
          HapticFeedback.heavyImpact();

          if (_isEmailVerified) {
            if (!mounted) return;

            Navigator.pushReplacementNamed(
              context,
              KRouter.mainNavigator,
            );
          } else if (_canResendEmail) {
            context.read<SignInCubit>().sendVerificationEmail();
            startResendTimer();
          }
        },
        animation: widget.animation,
        color: _isEmailVerified ? Colors.green[700] : context.accentColor(),
        buttonName: _isEmailVerified
            ? "Done!"
            : _canResendEmail
                ? "Resend email"
                : "Resend in ${getFormattedTimeFromAnInt(_resendTimer)}",
      ),
    );
  }

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

  void startResendTimer() {
    setState(() {
      _canResendEmail = false;
      _resendTimer = 60;
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
}
