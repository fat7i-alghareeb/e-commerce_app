import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/Features/authentication/data/domain/repo/auth_repo.dart';
import 'package:store_app/Features/authentication/presentation/manger/signIn/sign_in_cubit.dart';
import 'package:store_app/Features/authentication/presentation/view/verification_screen.dart';

import '../../Features/home/presentation/view/categories_list_screen.dart';
import '../../Features/Cart/data/repo/cart_products_repo_impl.dart';
import '../../Features/Cart/presentation/manger/cubit/cart_product_cubit.dart';
import '../../Features/authentication/presentation/view/auth_pages.dart';
import '../../Features/Navigator/presentation/view/navigator.dart';
import '../../Features/details/presentation/view/details.dart';
import '../../Features/home/data/domain/repo/products_repo_impl.dart';
import '../../Features/home/presentation/manger/categories cubit/categories_cubit.dart';
import '../../Features/home/presentation/manger/products cubit/products_cubit.dart';
import '../../Features/home/presentation/view/category_product_screen.dart';
import '../../Features/search/presentation/view/search_screen.dart';
import '../../shared/models/product.dart';
import '../service_locator.dart';
import 'router_paths.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    log('Navigating to: ${settings.name}'); // Debug print
    switch (settings.name) {
      case KRouter.authPage:
        return MaterialPageRoute(
          builder: (_) {
            return const AuthPages();
          },
        );
      case KRouter.verificationScreen:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (context) => SignInCubit(getIt.get<AuthRepo>()),
              child: const VerificationScreen(),
            );
          },
        );

      case KRouter.mainNavigator:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    CategoriesCubit(getIt.get<ProductRepoImpl>()),
              ),
              BlocProvider(
                create: (context) => ProductsCubit(
                  getIt.get<ProductRepoImpl>(),
                )..getAllProducts(),
              ),
            ],
            child: const MainNavigator(),
          ),
        );
      case KRouter.detailsScreen:
        return MaterialPageRoute(
          builder: (_) {
            final Map<String, dynamic> argument =
                settings.arguments as Map<String, dynamic>;
            final bool fromHome = argument["fromHome"];
            final Product product = argument["product"];
            return BlocProvider(
              create: (context) =>
                  CartProductCubit(getIt.get<CartProductsRepoImpl>()),
              child: DetailsScreen(product: product, fromHome: fromHome),
            );
          },
        );
      case KRouter.categoryProducts:
        return MaterialPageRoute(
          builder: (_) {
            final String categoryName = settings.arguments as String;
            return BlocProvider(
              create: (context) => CategoriesCubit(getIt.get<ProductRepoImpl>())
                ..fetchCategorizeProduct(categoryName),
              child: CategoryProducts(
                categoryName: categoryName,
              ),
            );
          },
        );
      case KRouter.searchScreen:
        return MaterialPageRoute(
          builder: (_) {
            return BlocProvider(
              create: (context) => ProductsCubit(getIt.get<ProductRepoImpl>()),
              child: const SearchScreen(),
            );
          },
        );
      case KRouter.categoriesListScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CategoriesCubit(getIt.get<ProductRepoImpl>()),
            child: const CategoriesListScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
