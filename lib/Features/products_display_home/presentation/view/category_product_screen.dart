import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/category products screen/category_screen_shimmer.dart';
import '../../../Navigator/presentation/view/widgets/drawer widgets/drawer.dart';
import '../manger/categories cubit/categories_cubit.dart';
import '../manger/categories cubit/categories_state.dart';
import 'widgets/category_product_screen_body.dart';

class CategoryProducts extends StatelessWidget {
  final String categoryName;
  const CategoryProducts({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerWidget(),
      body: SafeArea(
        child: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesProductsLoaded) {
              return CategoryProductsBody(
                categoryName: categoryName,
                products: state.products,
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
