import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Features/Cart/data/repo/cart_products_repo_impl.dart';
import '../../Features/Cart/presentation/manger/cubit/cart_product_cubit.dart';
import '../../Features/Log%20in/presentation/view/log_in_screens.dart';
import '../../Features/Navigator/presentation/view/navigator.dart';
import '../../Features/Splash/presentation/views/splash_view.dart';
import '../../Features/details/presentation/view/details.dart';
import '../../Features/products display(home)/data/repo/products_repo_impl.dart';
import '../../Features/products display(home)/presentation/manger/categories cubit/categories_cubit.dart';
import '../../Features/products display(home)/presentation/manger/products cubit/products_cubit.dart';
import '../../Features/products display(home)/presentation/view/category_product_screen.dart';
import '../../Features/search/presentation/view/search_screen.dart';
import '../../shared/models/product.dart';
import '../service_locator.dart';
import 'router_paths.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case KRouter.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
      case KRouter.logInPage:
        return MaterialPageRoute(
          builder: (_) => const LogInPageViewScreens(),
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
            final List<Product> products = settings.arguments as List<Product>;

            return BlocProvider(
                create: (context) =>
                    ProductsCubit(getIt.get<ProductRepoImpl>()),
                child: SearchScreen(products: products));
          },
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
