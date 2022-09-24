// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int?,
      totalPrice: (json['totalPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'quantity': instance.quantity,
      'product': instance.product,
      'totalPrice': instance.totalPrice,
    };
