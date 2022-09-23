import 'dart:convert';
import 'package:flutter/widgets.dart';
import '../model/product.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  List<Product> listProduct = [];
  String baseUrl = "https://fakestoreapi.com/products";

  bool isLoading = false;

  void getListProduct() async {
    isLoading = true;
    http.get(Uri.parse(baseUrl)).then((response) {
      var data = json.decode(response.body);
      listProduct =
          data.map<Product>((json) => Product.fromJson(json)).toList();
      isLoading = false;
      notifyListeners();
    }).catchError((onError) {
      isLoading = false;
      notifyListeners();
      debugPrint(onError);
    });
  }
}
