import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import '../model/product.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  List<Product> listProduct = [];
  static const baseUrl = "https://fakestoreapi.com/products";

  bool isLoading = false;

  void getListProduct() async {
    isLoading = true;
    _dio.get(baseUrl).then((response) {
      final data = response.data;

      listProduct =
          data.map<Product>((json) => Product.fromJson(json)).toList();

      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      debugPrint(onError);
      notifyListeners();
    });
  }
}
