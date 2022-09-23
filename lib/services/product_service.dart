import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_cart/model/product.dart';

class ProductService {
  final Dio _dio = Dio();
  static const baseUrl = "https://fakestoreapi.com/products";

  Future<List<Product>> getListProduct() async {
    List<Product> products = [];
    await _dio.get(baseUrl).then((response) {
      final data = response.data;

      products = data.map<Product>((json) => Product.fromJson(json)).toList();
    }).catchError((onError) {
      debugPrint(onError);
    });

    return products;
  }
}
