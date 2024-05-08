import 'widgets/cart_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/models/product.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../utils/service_locator.dart';
import '../../data/repo/cart_products_repo_impl.dart';
import '../manger/cubit/cart_product_cubit.dart';
import '../manger/cubit/cart_product_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> products = [];

    return BlocProvider(
      create: (context) => CartProductCubit(getIt.get<CartProductsRepoImpl>())
        ..fetchCardProduct(),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [const CustomAppBar(title: "")];
        },
        body: BlocBuilder<CartProductCubit, CartProductState>(
          builder: (context, state) {
            products = BlocProvider.of<CartProductCubit>(context).cartProducts;
            if (products.isNotEmpty) {
              return CartScreenBody(products: products);
            } else {
              return Center(
                child: Text(
                  '"There no items in the Cart"',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[350],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
