import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../manger/cubit/log_in_cubit.dart';
import '../../../../../../utils/functions/sign_in_indicator.dart';
import 'log_in_body.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key, required this.pageController});
  final PageController pageController;
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
      child: LogInBody(pageController: pageController),
    );
  }
}
