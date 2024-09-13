import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_app/utils/helper_extensions.dart';

import '../../../../../../utils/assets.dart';
import 'other_method_auth_widget.dart';

class AnimatedBottomPart extends StatelessWidget {
  const AnimatedBottomPart({
    super.key,
    required Animation<double> downAnimation,
    required this.pageController,
  }) : _downAnimation = downAnimation;

  final Animation<double> _downAnimation;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 3),
        end: Offset.zero,
      ).animate(_downAnimation),
      child: AnimatedBuilder(
        animation: _downAnimation,
        builder: (context, child) => Opacity(
          opacity: _downAnimation.value,
          child: Stack(
            children: [
              const Center(
                child: OtherMethodAuthWidget(
                  imagePath: AssetsImages.google,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                child: SizedBox(
                  height: 50,
                  child: Card(
                    color: context.accentColor(),
                    margin: EdgeInsets.zero,
                    child: IconButton(
                      onPressed: () {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                        HapticFeedback.heavyImpact();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: context.primaryColor(),
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
