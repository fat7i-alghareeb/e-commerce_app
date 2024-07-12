import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Review {
  @HiveField(0)
  int? rating;
  @HiveField(1)
  String? comment;
  @HiveField(2)
  DateTime? date;
  @HiveField(3)
  String? reviewerName;
  @HiveField(4)
  String? reviewerEmail;

  Review({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
