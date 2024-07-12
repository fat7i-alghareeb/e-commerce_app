import 'package:dartz/dartz.dart';

import '../../../../shared/models/product.dart';
import '../../../../utils/errors/failure.dart';

abstract class ProductsRepo {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, List<Product>>> getCategorizeProduct(String category);
}
