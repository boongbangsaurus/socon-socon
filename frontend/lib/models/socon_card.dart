import 'dart:convert';
import 'package:http/http.dart' as http;


class Socon {
  // 필수
  final int id;
  final String name;
  final int price;
  final String image;
  // 선택
  final String? storeName;
  final String? dueDate;
  final bool? is_main;
  final int? issued_quantity;
  final int? left_quantity;
  final bool? is_discounted;
  final int? discounted_price;    // type??
  final DateTime? createdAt;

  Socon({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    // 선택적인 필드들
    this.storeName,
    this.dueDate,
    this.is_main = false,
    this.issued_quantity = 0,
    this.left_quantity = 0,
    this.is_discounted = false,
    this.discounted_price,
    this.createdAt,
  });


  factory Socon.fromJson(Map<String, dynamic> json) {
    return Socon(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      storeName: json['storeName'],
      dueDate: json['dueDate'],
      is_main: json['is_main'],
      issued_quantity: json['issued_quantity'],
      left_quantity: json['left_quantity'],
      is_discounted: json['is_discounted'],
      discounted_price: json['discounted_price'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name': name,
      'price': price,
      'image': image,
      'storeName': storeName,
      'dueDate': dueDate,
      'is_main': is_main,
      'issued_quantity': issued_quantity,
      'left_quantity': left_quantity,
      'is_discounted': is_discounted,
      'discounted_price': discounted_price,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}



class ProductService {
  final String baseUrl = "/api/v1/stores/{store_id}"; // URL 수정하기

  Future<List<Socon>> fetchProducts() async {
    final response = await http.get(Uri.parse("$baseUrl/manage/info"));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Socon> products = body.map((dynamic item) => Socon.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  // 상품 추가
  Future<Socon> addProduct(Socon product) async {
    final response = await http.post(
      Uri.parse("$baseUrl/items"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 201) {
      return Socon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add product');
    }
  }
}





final List<Socon> socons = [
  Socon(id: 1, name : '소금빵', image:'https://cataas.com/cat', price: 3000, is_main: true, issued_quantity: 10, left_quantity: 2, is_discounted: true, discounted_price: 2400, createdAt: DateTime.parse('2024-05-23')),
  Socon(id: 2, name : '마카롱', image:'https://cataas.com/cat', price: 5000, is_main: false, issued_quantity: 20, left_quantity: 5, is_discounted: false, discounted_price: 4400, createdAt: DateTime.parse('2024-05-23')),
  Socon(id: 3, name : '콜라', image:'https://cataas.com/cat', price: 7000, is_main: false, issued_quantity: 10, left_quantity: 2, is_discounted: true, discounted_price: 1000, createdAt: DateTime.parse('2024-05-23')),
  Socon(id: 4, name : '치킨', image:'https://cataas.com/cat', price: 30000, is_main: false, issued_quantity: 10, left_quantity: 9, is_discounted: false, discounted_price: 20000, createdAt: DateTime.parse('2024-05-23')),
  Socon(id: 5, name : '치킨', image:'https://cataas.com/cat', price: 30000, is_main: false, issued_quantity: 10, left_quantity: 9, is_discounted: false, discounted_price: 20000, createdAt: DateTime.parse('2024-05-23')),
  Socon(id: 6, name : '치킨', image:'https://cataas.com/cat', price: 30000, is_main: false, issued_quantity: 10, left_quantity: 9, is_discounted: false, discounted_price: 20000, createdAt: DateTime.parse('2024-05-23')),
  Socon(id: 7, name : '치킨', image:'https://cataas.com/cat', price: 30000, is_main: false, issued_quantity: 10, left_quantity: 9, is_discounted: false, discounted_price: 20000, createdAt: DateTime.parse('2024-05-23')),
];
