import 'package:hive_flutter/hive_flutter.dart';
part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String price;
  @HiveField(3)
  final String category;

  @HiveField(5)
  final String description;
  @HiveField(6)
  final String image;

  Product({
    required this.description,
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      image: json['image'],
      title: json['title'],
      price: json['price'].toString(),
      category: json['category'],
      description: json['description'],
    );
  }
}
