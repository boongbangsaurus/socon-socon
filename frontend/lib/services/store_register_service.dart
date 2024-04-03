import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socon/models/store_register_model.dart';

/// [StoreRegisterService]
/// 백과 통신하기 위한 classq..

class StoreRegisterService {
  final String baseUrl = 'http://j10c207.p.ssafy.io:8000'; // 통신 url
  // final String baseUrl = 'https://6739-61-84-244-233.ngrok-free.app';

  Future<bool> registerStore(StoreRegisterModel storeRegisterModel) async {
    final url = Uri.parse('$baseUrl/api/v1/stores');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    debugPrint('vvvvvvvvvvvv');
    print(storeRegisterModel.toJson());

    final response = await http.post(url,
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(storeRegisterModel.toJson()));
    debugPrint('vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv');

    if (response.statusCode == 200) {
      print('응답ㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂㅂ');
      print(utf8.decode(response.bodyBytes));
      return true;
    } else {
      print('응답');
      print(utf8.decode(response.bodyBytes));
      // 에러 처리
      return false;
    }
  }
}


