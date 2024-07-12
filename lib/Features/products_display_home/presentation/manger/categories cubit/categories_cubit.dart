import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/models/product.dart';
import '../../../../../utils/constants.dart';
import '../../../data/repo/products_repo_impl.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  ProductRepoImpl productRepo;
  List<String> _categoriesName = [];
  List<String> _categoriesImage = [];
  final List<List<String>> _categories = [];
  List<Product> categorizeProduct = [];
  CategoriesCubit(this.productRepo) : super(CategoriesInitial());
  void setCategories() {
    _categoriesName = categoriesAvailable.keys.toList();
    _categories.add(_categoriesName);
    _categoriesImage = categoriesAvailable.values.toList();
    _categories.add(_categoriesImage);
  }

  get categories => _categories;

  Future<void> fetchCategorizeProduct(String category) async {
    emit(CategoriesLoading());
    final results = await productRepo.getCategorizeProduct(category);

    results.fold(
      (failure) {
        emit(CategoriesFailure(failureMessage: failure.message));
      },
      (products) {
        emit(CategoriesProductsLoaded(products: products));
      },
    );
  }
}
