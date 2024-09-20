import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manger/products cubit/products_cubit.dart';
import '../manger/products cubit/products_state.dart';
import 'widgets/home widgets/main_screen_shimmer.dart';
import 'widgets/home_body.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      onRefresh: () {
        return context.read<ProductsCubit>().getAllProducts();
      },
      animSpeedFactor: 3,
      showChildOpacityTransition: false,
      child: BlocBuilder<ProductsCubit, ProductsState>(
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
      ),
    );
  }
}
