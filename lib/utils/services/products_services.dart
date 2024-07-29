import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import '../../shared/models/api_response.dart';
part 'products_services.g.dart';

@RestApi(baseUrl: "https://dummyjson.com/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/products')
  Future<ApiResponse> getProducts(@Queries() Map<String, dynamic> queries);
  @GET('/products/search')
  Future<ApiResponse> getSearchProducts(
      @Queries() Map<String, dynamic> queries);
  @GET('/products/category/{category}')
  Future<ApiResponse> getCategorizedProducts(@Path('category') String id);
}
