import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../utils/helper_extensions.dart';

import '../../../../../shared/models/product.dart';
import '../../../../Cart/presentation/manger/cubit/cart_product_cubit.dart';
import '../../../../Cart/presentation/manger/cubit/cart_product_state.dart';

class AddToCartWidget extends StatefulWidget {
  const AddToCartWidget({
    super.key,
    required this.product,
    required this.fromHome,
  });

  final Product product;
  final bool fromHome;
  @override
  State<AddToCartWidget> createState() => _AddToCartWidgetState();
}

class _AddToCartWidgetState extends State<AddToCartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.3).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _colorAnimation = ColorTween(
      begin: context.accentColor(),
      end: Colors.green,
    ).animate(_animationController);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return GestureDetector(
            onTap: () =>
                context.read<CartProductCubit>().saveProduct(widget.product),
            child: Container(
              height: size.height * .07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: _colorAnimation.value,
              ),
              child: Center(
                child: BlocListener<CartProductCubit, CartProductState>(
                  listener: (context, state) {
                    if (state is CartProductAddedSuccessfully) {
                      _animationController.forward();
                    }
                  },
                  child: AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              widget.fromHome ? "\$148" : "Add another one",
                              style: TextStyle(
                                fontSize: 20,
                                color: context.primaryColor(),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.fromHome
                                  ? "Add To Bag"
                                  : "Add another one",
                              style: TextStyle(
                                fontSize: 20,
                                color: context.primaryColor(),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
