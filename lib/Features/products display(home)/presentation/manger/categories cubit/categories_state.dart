import '../../../../../shared/models/product.dart';

sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesProductsLoaded extends CategoriesState {
  final List<Product> products;

  CategoriesProductsLoaded({required this.products});
}

final class CategoriesFailure extends CategoriesState {
  final String failureMessage;

  CategoriesFailure({required this.failureMessage});
}
