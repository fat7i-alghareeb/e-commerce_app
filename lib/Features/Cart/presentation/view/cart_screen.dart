import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/utils/assets.dart';
import '../../../../shared/models/product.dart';
import '../../../../utils/service_locator.dart';
import '../../data/repo/cart_products_repo_impl.dart';
import '../manger/cubit/cart_product_cubit.dart';
import '../manger/cubit/cart_product_state.dart';
import 'widgets/cart_screen_body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> products = [];

    return SafeArea(
      child: BlocProvider(
        create: (context) => CartProductCubit(getIt.get<CartProductsRepoImpl>())
          ..fetchCardProduct(),
        child: BlocBuilder<CartProductCubit, CartProductState>(
          builder: (context, state) {
            products = BlocProvider.of<CartProductCubit>(context).cartProducts;
            if (products.isNotEmpty) {
              return CartScreenBody(products: products);
            } else {
              return const CartScreenEmptyBody();
            }
          },
        ),
      ),
    );
  }
}

class CartScreenEmptyBody extends StatelessWidget {
  const CartScreenEmptyBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(34.0),
      child: Column(
        children: [
          const Text(
            "Cart",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetsImages.emptyBag,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Your Cart is Empty',
                  style: TextStyle(
                    fontSize: 23,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
