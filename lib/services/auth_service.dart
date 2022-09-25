import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_cart/model/product.dart';

import '../model/user.dart';

class AuthService {
  final Dio _dio = Dio();
  static const baseUrl = "https://fakestoreapi.com/auth";

  Future<User?> login(String username, String password) async {
    User? user;
    final data = {
      "username": "mor_2314",
      "password": "83r5^_",
    };
    final dio = Dio();

    await dio.post("$baseUrl/login", data: data).then((response) {
      if (response.statusCode == 200) {
        final body = response.data;
        user = User(token: body['token'], username: username);
      }
    }).catchError((onError) {
      debugPrint(onError);
    });

    return user;
  }
}
