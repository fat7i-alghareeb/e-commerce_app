import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../Features/authentication/data/domain/repo/auth_repo.dart';
import '../Features/authentication/presentation/manger/signIn/sign_in_cubit.dart';
import '../Features/search/data/repo/search_repo.dart';
import 'services/firebase_auth_services.dart';
import '../Features/Cart/data/repo/cart_products_repo_impl.dart';
import '../Features/home/data/domain/repo/products_repo_impl.dart';
import 'services/products_services.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(ApiService(createAndSetupDio()));
  getIt.registerSingleton<ProductRepoImpl>(
    ProductRepoImpl(
      apiService: getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<CartProductsRepoImpl>(
    CartProductsRepoImpl(),
  );
  getIt.registerSingleton<SearchRepo>(
    SearchRepo(
      getIt.get<ApiService>(),
    ),
  );
  getIt.registerSingleton<FirebaseAuthServices>(FirebaseAuthServices());
  getIt.registerSingleton<AuthRepo>(
    AuthRepo(
      firebaseAuthServices: getIt.get<FirebaseAuthServices>(),
    ),
  );
  getIt.registerSingleton<SignInCubit>(
    SignInCubit(getIt.get<AuthRepo>()),
  );
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
