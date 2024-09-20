import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../utils/functions/show_toast.dart';
import '../../../manger/signIn/sign_in_cubit.dart';
import '../../../manger/signIn/sign_in_state.dart';
import '../../../../../../utils/functions/sign_in_indicator.dart';
import '../../../../../../utils/router/router_paths.dart';
import 'sign_in_body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key, required this.pageController});
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInLoading) {
          signInLoadingIndicator(context: context, isLoading: true);
        } else if (state is SignInFailure) {
          showToast(message: state.message, color: Colors.red[700]);
          signInLoadingIndicator(context: context, isLoading: false);
        } else if (state is SignInSuccess) {
          signInLoadingIndicator(context: context, isLoading: false);
          Navigator.pushNamed(context, KRouter.verificationScreen);
        }
      },
      child: SignInBody(
        pageController: pageController,
      ),
    );
  }

  final PageController pageController;
}
