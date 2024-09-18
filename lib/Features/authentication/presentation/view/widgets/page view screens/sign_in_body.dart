import 'package:flutter/material.dart';
import '../../../../../../utils/helper_extensions.dart';
import '../auth pages widgets/sign_in_middle_part.dart';

class SignInBody extends StatefulWidget {
  const SignInBody({
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> with TickerProviderStateMixin {
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, -4),
                        end: Offset.zero,
                      ).animate(_animation),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Sign in",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: context.accentColor(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "just a few quick things to get started",
                            style: TextStyle(
                              fontSize: 20,
                              color: context.onPrimaryColor(),
                            ),
                          )
                        ],
                      ),
                    ),
                    ///////////////////////////////////////////////////////////////////////////////////////////
                    const SizedBox(height: 50),
                    ///////////////////////////////////////////////////////////////////////////////////////////
                    SignInMiddlePartUI(
                      animation: _animation,
                      pageController: widget.pageController,
                    ),
                    ///////////////////////////////////////////////////////////////////////////////////////////
                  ],
                ),
              ),
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
    _controller.forward();
  }
}
