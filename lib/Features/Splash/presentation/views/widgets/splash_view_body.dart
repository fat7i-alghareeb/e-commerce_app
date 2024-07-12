import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../../shared/models/user.dart';
import '../../../../../utils/router/router_paths.dart';
import 'animated_logo.dart';
import 'sliding_text.dart';

class SplashViewbody extends StatefulWidget {
  const SplashViewbody({super.key});

  @override
  State<SplashViewbody> createState() => _SplashViewbodyState();
}

class _SplashViewbodyState extends State<SplashViewbody>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  late Animation<double> imageAnimation;

  @override
  void initState() {
    super.initState();
    initAnimations();
    navigateToHome();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedLogo(imageAnimation: imageAnimation),
        const SizedBox(
          height: 30,
        ),
        SlidingText(slidingAnimation: slidingAnimation),
      ],
    );
  }

  void initAnimations() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 5), end: Offset.zero)
            .animate(animationController);
    imageAnimation =
        Tween<double>(begin: 0, end: 180).animate(animationController);

    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (Hive.box<User>("user_box").isEmpty) {
          Navigator.pushReplacementNamed(context, KRouter.logInPage);
        } else {
          Navigator.pushReplacementNamed(context, KRouter.mainNavigator);
        }
      },
    );
  }
}
