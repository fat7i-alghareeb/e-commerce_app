import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../utils/errors/failure.dart';
import 'products_repo.dart';

import '../../../../utils/services/products_services.dart';
import '../../../../shared/models/product.dart';

class ProductRepoImpl implements ProductsRepo {
  final ApiService apiService;

  ProductRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final data = await apiService.get();
      final products =
          data.map((product) => Product.fromJson(product)).toList();
      return right(products);
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

  @override
  Future<Either<Failure, List<Product>>> getCategorizeProduct(
      String category) async {
    try {
      final data = await apiService.get(endPoint: '/category/$category');
      final products =
          data.map((product) => Product.fromJson(product)).toList();
      return right(products);
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
