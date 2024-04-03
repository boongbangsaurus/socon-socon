import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socon/models/product_detail_model.dart';

/// [PaymentService]
/// 백과 통신하기 위한 class


class PaymentService {
  final String baseUrl = 'http://j10c207.p.ssafy.io:8000'; // 통신 url

  // 상품 주문 요청
  Future<String> sendPaymentRequest(Map<String, dynamic> orderData) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/orders'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
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
  Future<Map<String, dynamic>> getMenuDetail(int storeId, int menuId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    print('get 요청 전전전전전');
    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/stores/$storeId/items/$menuId'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    print('get 요청 후후후후후후후');

    if (response.statusCode == 200) {
      debugPrint(
          '상품 상세페이지 조회 성공 ################################################');
      // print(utf8.decode(response.bodyBytes));
      final String body = utf8.decode(response.bodyBytes);
      final decodedBody = jsonDecode(body);
      final Map<String, dynamic> dataBody = decodedBody['data_body'];
      print(dataBody);
      print("?????????????????????????");
      // print(GetProductDetailModel.fromJson(dataBody));
      print("?????????????????????????");
      return dataBody;
      // return GetProductDetailModel.fromJson(dataBody);
      // return ProductDetailModel.fromJson(json.decode(response.body));


    } else {
      throw Exception('상세 조회 실패');
    }
  }
}