import 'package:hive_flutter/hive_flutter.dart';
import 'cart_products_repo.dart';

import '../../../../shared/models/product.dart';

class CartProductsRepoImpl implements CartProductsRepo {
  final productBox = Hive.box<Product>("product_box");
  @override
  void saveProduct(Product product) {
    productBox.add(product);
  }

  @override
  List<Product> fetchCartProduct() {
    return productBox.values.toList();
  }

  @override
  void unSaveProduct(int index) {
    productBox.deleteAt(index);
  }
}
