import 'package:flutter/material.dart';

// 소콘 상세보기 model
class ProductDetailModel {
  final int id;
  final String name;
  final String? image;
  int price;
  String? summary;
  String? description;
  String? store_image;

  int? quantity;

  ProductDetailModel({
    required this.id,
    required this.name,
    required this.price,
    this.image = '',
    this.summary = '',
    this.description = '',
    this.store_image = '',

    this.quantity,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      summary: json['summary'],
      description: json['description'],
      store_image: json['store_image'],
      quantity: json['quantity'],
    );
  }





  Map<String, dynamic> toJsonPayment() => {
    'issuedId': '',
    'itemName': '',
    'price': '',
    'quantity': '',
  };

  // Map<String, dynamic> toJsonPayment() => {
  //   'issuedId': 2,
  //   'itemName': '유뷰꼬마김밥',
  //   'price': 400,
  //   'quantity': 1,
  // };

}


class GetProductDetailModel {
  int id;
  String name;
  String item_image;
  String store_image;
  int price;
  String? summary;
  String? description;

  int? quantity;

  GetProductDetailModel({
    required this.id,
    required this.name,
    this.item_image = '',
    this.store_image = '',
    required this.price,
    this.summary = '',
    this.description = '',

  });

  factory GetProductDetailModel.fromJson(Map<String, dynamic> json) {
    return GetProductDetailModel(
      id: json['id'],
      name: json['name'],
      item_image: json['image'],
      store_image: json['store_image'],
      price: json['price'],
      summary: json['summary'],
      description: json['description'],
    );
  }

}