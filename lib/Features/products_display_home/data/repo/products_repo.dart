import 'package:dartz/dartz.dart';
import '../../../../utils/errors/failure.dart';

import '../../../../shared/models/product.dart';

abstract class ProductsRepo {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, List<Product>>> getCategorizeProduct(String category);
}
