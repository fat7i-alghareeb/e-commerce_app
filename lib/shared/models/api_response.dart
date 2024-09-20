import 'package:json_annotation/json_annotation.dart';

import 'product.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiResponse {
  List<Product>? products;

  ApiResponse({this.products});

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
