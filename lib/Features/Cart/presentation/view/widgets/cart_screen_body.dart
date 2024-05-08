import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/models/product.dart';
import '../../../../Navigator/presentation/view/widgets/slidable.dart';
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
    return ListView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SlidableWidget(
            child: CartProductWidget(
              product: products[index],
            ),
            deleteAction: (context) {
              BlocProvider.of<CartProductCubit>(context).unSaveProduct(index);
              HapticFeedback.vibrate();
            },
            confirmAction: (context) {
              null;
            },
          ),
        );
      },
    );
  }
}
