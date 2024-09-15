import 'package:flutter/material.dart';
import '../../../../../../utils/assets.dart';
import '../auth pages widgets/animated_bottom_part.dart';
import '../auth pages widgets/animated_divider.dart';
import '../auth pages widgets/log_in_middle_part_Ui.dart';

class LogInBody extends StatefulWidget {
  const LogInBody({
    super.key,
    required this.pageController,
  });

  final PageController pageController;
  @override
  State<LogInBody> createState() => _LogInBodyState();
}

class _LogInBodyState extends State<LogInBody> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late AnimationController _downAnimationController;
  late Animation<double> _downAnimation;
  late AnimationController _colorAnimationController;
  late Animation<int> _colorAnimation;
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              LogInMiddlePartUI(
                  animation: _animation, pageController: widget.pageController),
              ///////////////////////////////////////////////////////////////////////////////////////////
              const SizedBox(height: 40),
              ///////////////////////////////////////////////////////////////////////////////////////////
              AnimatedDivider(colorAnimation: _colorAnimation),
              const SizedBox(height: 50),
              AnimatedBottomPart(
                downAnimation: _downAnimation,
              ),
              //////////////////////////////////////////////////////////////////////////////////////////////
              const SizedBox(height: 50),
            ],
          ),
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
