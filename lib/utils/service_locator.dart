import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../Features/products display(home)/data/repo/products_repo_impl.dart';
import '../Features/Cart/data/repo/cart_products_repo_impl.dart';
import 'services/products_services.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<ProductRepoImpl>(
    ProductRepoImpl(
      apiService: getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<CartProductsRepoImpl>(CartProductsRepoImpl());
}
