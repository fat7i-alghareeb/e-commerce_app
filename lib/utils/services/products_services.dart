import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:store_app/shared/models/product.dart';
part 'products_services.g.dart';

@RestApi(baseUrl: "https://fakestoreapi.com/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/products')
  Future<List<Product>> getProducts();
  @GET('/products/category/{category}')
  Future<List<Product>> getCategorizedProducts(@Path('category') String id);
}
