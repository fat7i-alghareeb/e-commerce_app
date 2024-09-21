import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/shared/cubits/cubit/user_info_cubit.dart';
import '../../../../../../utils/functions/show_toast.dart';
import '../../../../../../utils/router/router_paths.dart';
import '../../../manger/cubit/log_in_cubit.dart';
import '../../../../../../utils/functions/sign_in_indicator.dart';
import 'log_in_body.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key, required this.pageController});
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return BlocListener<LogInCubit, LogInState>(
      listener: (context, state) async {
        if (state is LogInLoading) {
          signInLoadingIndicator(context: context, isLoading: true);
        } else if (state is LogInFailure) {
          signInLoadingIndicator(context: context, isLoading: false);

          showToast(message: state.message, color: Colors.red[700]);
        } else if (state is LogInPasswordResetFailure) {
          showToast(message: state.message, color: Colors.red[700]);
        } else if (state is LogInPasswordResetSent) {
          showToast(message: state.message, color: Colors.green[700]);
        } else if (state is LogInSuccess) {
          signInLoadingIndicator(context: context, isLoading: false);
          context.read<UserInfoCubit>().saveUser(userEntity: state.userEntity);
          Navigator.pushNamed(context, KRouter.mainNavigator);
        }
      },
      child: LogInBody(pageController: pageController),
    );
  }
}
