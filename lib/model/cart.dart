import 'package:shopping_cart/model/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  int? quantity = 1;
  Product? product;
  num? totalPrice = 0.0;

  Cart({this.product, this.quantity, this.totalPrice});

  num getTotalPrice() {
    return quantity! * product!.price!;
  }

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
