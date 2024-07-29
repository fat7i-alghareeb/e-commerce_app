import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:store_app/shared/models/api_response.dart';
import '../../../../utils/errors/failure.dart';
import '../../../../utils/services/products_services.dart';

class SearchRepo {
  final ApiService apiService;

  SearchRepo(this.apiService);
  Future<Either<Failure, ApiResponse>> fetchSearchedProducts(
      {required Map<String, dynamic> queries}) async {
    try {
      ApiResponse apiResponse = await apiService.getSearchProducts(queries);
      return right(apiResponse);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDiorError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
