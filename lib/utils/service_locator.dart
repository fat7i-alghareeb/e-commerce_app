import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../Features/Cart/data/repo/cart_products_repo_impl.dart';
import '../Features/products_display_home/data/repo/products_repo_impl.dart';
import 'services/products_services.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(createAndSetupDio()));
  getIt.registerSingleton<ProductRepoImpl>(
    ProductRepoImpl(
      apiService: getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<CartProductsRepoImpl>(CartProductsRepoImpl());
}

Dio createAndSetupDio() {
  Dio dio = Dio();

  dio
    ..options.connectTimeout = const Duration(milliseconds: 20000)
    ..options.receiveTimeout = const Duration(milliseconds: 20000);

  dio.interceptors.add(LogInterceptor(
    responseBody: true,
    error: true,
    requestHeader: false,
    responseHeader: false,
    request: true,
    requestBody: true,
  ));

  return dio;
}
