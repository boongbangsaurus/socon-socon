import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:socon/models/product_detail_model.dart';

/// [PaymentService]
/// 백과 통신하기 위한 class


class PaymentService {
  final String baseUrl = 'http://j10c207.p.ssafy.io:8000'; // 통신 url

  // 상품 주문 요청
  Future<String> sendPaymentRequest(Map<String, dynamic> orderData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/orders'),
      // headers: <String, String>{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 200) {
      debugPrint(
          '상품 주문요청 조회 성공################################################');
      print('${jsonDecode(response.body)}===========================');
      return json.decode(response.body)['orderUid'];
    } else {
      // throw Exception('주문 실패');
      return json.decode(response.body);
    }
  }



  // 상품 상세조회
  Future<ProductDetailModel> getMenuDetail(String storeId, String menuId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/stores/{$storeId}/items/{$menuId}'),
    );

    if (response.statusCode == 200) {
      debugPrint(
          '상품 상세페이지 조회 성공 ################################################');
      return ProductDetailModel.fromJson(json.decode(response.body));

    } else {
      throw Exception('상세 조회 실패');
    }
  }



}