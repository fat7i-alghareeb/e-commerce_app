import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  final baseUrl = "https://fakestoreapi.com/products";

  ApiService(this._dio);

  Future<List<dynamic>> get({String? endPoint}) async {
    var response = await _dio.get('$baseUrl${endPoint ?? ""}');
    return response.data;
  }
}
