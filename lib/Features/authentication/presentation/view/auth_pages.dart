import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/authentication/presentation/manger/cubit/log_in_cubit.dart';
import 'package:store_app/Features/authentication/presentation/manger/signIn/sign_in_cubit.dart';
import 'package:store_app/Features/authentication/presentation/view/widgets/page%20view%20screens/sign_in_screen.dart';
import '../../../../utils/service_locator.dart';
import '../../data/domain/repo/auth_repo.dart';
import 'widgets/page view screens/log_in_screen.dart';
import 'widgets/page view screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class AuthPages extends StatefulWidget {
  const AuthPages({
    super.key,
  });
  @override
  State<AuthPages> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<AuthPages> {
  late final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screen = [
      WelcomeScreen(
        pageController: pageController,
      ),
      BlocProvider(
        create: (context) => LogInCubit(getIt.get<AuthRepo>()),
        child: LogInPage(
          pageController: pageController,
        ),
      ),
      BlocProvider(
        create: (context) => SignInCubit(getIt.get<AuthRepo>()),
        child: SignInScreen(
          pageController: pageController,
        ),
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: screen,
      ),
    );
  }
}
