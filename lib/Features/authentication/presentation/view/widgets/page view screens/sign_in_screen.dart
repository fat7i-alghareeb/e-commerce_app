import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/authentication/presentation/manger/signIn/sign_in_cubit.dart';
import 'package:store_app/Features/authentication/presentation/manger/signIn/sign_in_state.dart';
import 'package:store_app/utils/functions/sign_in_indicator.dart';
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 2),
              content: Text(state.message),
              backgroundColor: Colors.red[700],
              padding: const EdgeInsets.all(25),
            ),
          );
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
