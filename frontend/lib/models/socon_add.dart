import 'dart:convert';
import 'package:http/http.dart' as http;


class SoconAdd {
  // 필수
  final id;
  final String? soconName;
  final String? imageUrl;
  final int price;
  // 선택
  final String? storeName;
  final String? dueDate;
  final bool? isMain;
  final int? maxQuantity;
  final int? issuedQuantity;
  final bool? isDiscounted;
  final int? discountedPrice;
  final DateTime? createdAt;

  SoconAdd({
    required this.id,
    required this.soconName,
    required this.imageUrl,
    required this.price,
    // 선택적인 필드들
    this.storeName,
    this.dueDate,
    this.isMain = false,
    this.maxQuantity = 0,
    this.issuedQuantity = 0,
    this.isDiscounted = false,
    this.discountedPrice,
    this.createdAt,
  });


  factory SoconAdd.fromJson(Map<String, dynamic> json) {
    return SoconAdd(
      id : json['id'],
      soconName: json['soconName'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      storeName: json['storeName'],
      dueDate: json['dueDate'],
      isMain: json['isMain'],
      maxQuantity: json['maxQuantity'],
      issuedQuantity: json['issuedQuantity'],
      isDiscounted: json['isDiscounted'],
      discountedPrice: json['discountedPrice'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'soconName': soconName,
      'price': price,
      'imageUrl': imageUrl,
      'storeName': storeName,
      'dueDate': dueDate,
      'isMain': isMain,
      'maxQuantity': maxQuantity,
      'issuedQuantity': issuedQuantity,
      'isDiscounted': isDiscounted,
      'discountedPrice': discountedPrice,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}



class ProductService {
  final String baseUrl = "/api/v1/stores/{store_id}"; // URL 수정하기

  Future<List<SoconAdd>> fetchProducts() async {
    final response = await http.get(Uri.parse("$baseUrl/manage/info"));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<SoconAdd> products = body.map((dynamic item) => SoconAdd.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  // 상품 추가
  Future<SoconAdd> addProduct(SoconAdd product) async {
    final response = await http.post(
      Uri.parse("$baseUrl/items"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 201) {
      return SoconAdd.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add product');
    }
  }
}
