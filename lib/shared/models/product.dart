import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'review.dart';
part 'product.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final double price;
  @HiveField(5)
  double? discountPercentage;
  @HiveField(6)
  double? rating;
  @HiveField(7)
  String? brand;
  @HiveField(8)
  String? shippingInformation;
  @HiveField(9)
  String? availabilityStatus;
  final List<Review>? reviews;
  @HiveField(10)
  String? returnPolicy;
  @HiveField(11)
  final List<String> images;
  @HiveField(12)
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    this.discountPercentage,
    this.rating,
    this.brand,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    required this.images,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
