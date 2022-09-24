import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'id')
  int? id;
  @JsonValue("title")
  String? title;
  @JsonValue("price")
  num? price;
  @JsonValue("description")
  String? description;
  @JsonValue("image")
  String? image;
  @JsonValue("category")
  String? category;
  @JsonValue("quantity")
  int? quantity;

  Product({
    this.id,
    this.title,
    this.price,
    this.description,
    this.image,
    this.quantity,
    this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
