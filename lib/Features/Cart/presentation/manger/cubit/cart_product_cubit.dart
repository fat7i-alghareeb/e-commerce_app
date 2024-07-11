import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/models/product.dart';
import '../../../data/repo/cart_products_repo_impl.dart';
import 'cart_product_state.dart';

class CartProductCubit extends Cubit<CartProductState> {
  final CartProductsRepoImpl cartProductsRepo;
  CartProductCubit(this.cartProductsRepo) : super(CartProductInitial());
  List<Product> _cartProducts = [];
  void saveProduct(Product product) {
    try {
      Product x = Product(
          description: product.description,
          id: product.id,
          images: product.images,
          title: product.title,
          price: product.price,
          category: product.category,
          brand: product.brand,
          reviews: product.reviews,
          thumbnail: product.thumbnail);
      _cartProducts.add(x);
      cartProductsRepo.saveProduct(x);
      emit(CartProductAddedSuccessfully());
    } catch (e) {
      emit(CartProductFailure());
    }
  }

  void unSaveProduct(int index) {
    cartProductsRepo.unSaveProduct(index);
    fetchCardProduct();
  }

  void fetchCardProduct() {
    _cartProducts = cartProductsRepo.fetchCartProduct();
    emit(CartProductChanged());
  }

  List<Product> get cartProducts => _cartProducts;
}
