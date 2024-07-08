import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manger/products cubit/products_cubit.dart';
import '../manger/products cubit/products_state.dart';
import 'widgets/home_body.dart';
import 'widgets/main_screen_shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoaded) {
          return HomeBody(
            products: state.products,
          );
        } else if (state is ProductsError) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else {
          return const MainScreenShimmer();
        }
      },
    );
  }
}
