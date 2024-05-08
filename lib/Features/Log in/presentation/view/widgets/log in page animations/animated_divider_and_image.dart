import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../utils/assets.dart';
import '../log in page widgets/other_method_auth_widget.dart';

class AnimatedDividerAndImage extends StatelessWidget {
  final Animation<double> dividerAnimation;
  final Animation<double> imageAnimation;
  final Animation<int> colorAnimation;
  final PageController pageController;
  const AnimatedDividerAndImage({
    super.key,
    required this.dividerAnimation,
    required this.imageAnimation,
    required this.colorAnimation,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        dividerAnimation,
        imageAnimation,
        colorAnimation,
      ]),
      builder: (context, child) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                100 * (1 - dividerAnimation.value),
                0,
                10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Color.fromRGBO(
                          189, 189, 189, colorAnimation.value / 255),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Opacity(
                      opacity: dividerAnimation.value,
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Color.fromRGBO(
                          189, 189, 189, colorAnimation.value / 255),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Opacity(
              opacity: imageAnimation.value,
              child: Stack(
                children: [
                  Positioned(
                    left: 15,
                    bottom: 13,
                    child: Card(
                      color: Theme.of(context).colorScheme.secondary,
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
                          color: Theme.of(context).colorScheme.primary,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                  const Center(
                    child:
                        OtherMethodAuthWidget(imagePath: AssetsImages.google),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
