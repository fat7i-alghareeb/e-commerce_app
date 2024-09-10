import 'widgets/page view screens/log_in_screen.dart';
import 'widgets/page view screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class AuthPages extends StatefulWidget {
  const AuthPages({super.key});

  @override
  State<AuthPages> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<AuthPages> {
  final PageController pageController = PageController();

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
      LoginPage(
        pageController: pageController,
      ),
    ];
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: screen,
      ),
    );
  }
}
