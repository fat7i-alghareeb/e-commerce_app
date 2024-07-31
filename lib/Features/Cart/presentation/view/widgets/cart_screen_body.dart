import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/shared/widgets/sliver_sized_box.dart';
import 'package:store_app/utils/helper_extensions.dart';

import '../../../../../shared/models/product.dart';
import 'slidable.dart';
import '../../manger/cubit/cart_product_cubit.dart';
import 'cart_product_widget.dart';

class CartScreenBody extends StatelessWidget {
  const CartScreenBody({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15,
        top: 34,
      ),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Cart",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SliverSizedBox(
            height: 36,
          ),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Remove All ",
                style: TextStyle(
                  fontSize: 18,
                  color: context.accentColor(),
                ),
              ),
            ),
          ),
          const SliverSizedBox(
            height: 20,
          ),
          SliverList.builder(
            itemCount: products.length,
            //   padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return SlidableWidget(
                child: CartProductWidget(
                  product: products[index],
                ),
                deleteAction: (context) {
                  BlocProvider.of<CartProductCubit>(context)
                      .unSaveProduct(index);
                  HapticFeedback.vibrate();
                },
                confirmAction: (context) {
                  null;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
