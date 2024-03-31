import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:socon/models/location.dart';

/// [SogonService]
/// 백과 API 통신하기 위한 Class
class SogonService {
  final String baseUrl = 'http://j10c207.p.ssafy.io:8000'; // 통신 url

  // 로그인 요청 api
  Future<List?> getMarker(Locations location) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    print("############ get Token, local: getMarker ###########");
    print(jsonEncode(location.toJson()));
    print(accessToken);
    print("############ get Token: getMarker ###########");

    final res = await http.post(
      Uri.parse('$baseUrl/api/v1/sogons/list'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(location.toJson()),
    );
    if (res.statusCode == 200) {
      debugPrint(
          'getMarker res 200 ################################################');
      print(jsonDecode(res.body));
      debugPrint(
          'getMarker res 200 ################################################');

      final body = jsonDecode(res.body);
      final List dataBody = body['data_body'];
      // final String accessToken = body['data_body']['accessToken'];
      // final String refreshToken = body['data_body']['refreshToken'];
      return dataBody; // accessToken, refreshToken 반환
    } else {
      debugPrint(
          'getMarker res not 200 ################################################');
      print(jsonDecode(res.body));
      debugPrint(
          'getMarker res not 200 ################################################');

      return null;
    }
  }
}
