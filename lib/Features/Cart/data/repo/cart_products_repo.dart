import '../../../../shared/models/product.dart';

abstract class CartProductsRepo {
  void saveProduct(Product product);
  List<Product> fetchCartProduct();
  void unSaveProduct(int index);
}
