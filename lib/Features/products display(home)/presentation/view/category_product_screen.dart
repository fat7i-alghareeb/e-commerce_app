import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/widgets/custom_app_bar.dart';
import 'widgets/category_screen_shimmer.dart';
import 'widgets/products_grid_view.dart';
import '../../../Navigator/presentation/view/widgets/drawer widgets/drawer.dart';
import '../manger/categories cubit/categories_cubit.dart';
import '../manger/categories cubit/categories_state.dart';

class CategoryProducts extends StatelessWidget {
  final String categoryName;
  const CategoryProducts({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerWidget(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            CustomAppBar(title: categoryName),
          ];
        },
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesProductsLoaded) {
              return ProductsGridView(
                products: state.products,
                isScrollable: false,
              );
            } else if (state is CategoriesFailure) {
              return Center(
                child: Text(state.failureMessage),
              );
            } else {
              return const CategoryScreenShimmer();
            }
          },
        ),
      ),
    );
  }
}
