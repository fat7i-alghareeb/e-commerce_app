import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repo/products_repo_impl.dart';

import '../../../../../shared/models/product.dart';
import '../../../../../utils/constants.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepoImpl productRepo;
  List<Product> products = [];
  ProductsCubit(this.productRepo) : super(ProductsInitial());
  Future<void> getAllProducts() async {
    emit(ProductsLoading());
    final results = await productRepo.getAllProducts();

    results.fold(
      (failure) {
        emit(ProductsError(errorMessage: failure.message));
      },
      (products) {
        products.removeWhere(
          (product) => !categories.contains(product.category),
        );
        products.shuffle();
        this.products = products;
        emit(ProductsLoaded(products: products));
      },
    );
  }
}
