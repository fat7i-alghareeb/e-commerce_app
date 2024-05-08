import '../../../../../shared/models/product.dart';

abstract class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final List<Product> products;

  ProductsLoaded({required this.products});
}

final class ProductsError extends ProductsState {
  final String errorMessage;

  ProductsError({required this.errorMessage});
}
