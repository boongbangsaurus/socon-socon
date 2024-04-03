import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:socon/models/location.dart';

import '../models/locations.dart';

/// [SogonService]
/// 백과 API 통신하기 위한 Class
class SogonService {
  final String baseUrl = 'http://j10c207.p.ssafy.io:8000'; // 통신 url
  // final String baseUrl = 'https://0918-121-178-98-12.ngrok-free.app'; // 통신 url

  // marker 요청 api
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
      // final body = jsonDecode(res.body);
      // final List dataBody = body['data_body'];
      // final List<dynamic> dataBody = body['data_body'] as List<dynamic>;
      final String body = utf8.decode(res.bodyBytes);
      print(body);
      final List<dynamic> dataBody =
          jsonDecode(body)['data_body'] as List<dynamic>;
      debugPrint(
          'getMarker res 200 ################################################');
      // print(jsonDecode(res.body));
      // print(body['data_body'].runtimeType);
      print(dataBody);
      debugPrint(
          'getMarker res 200 ################################################');
      // final String accessToken = body['data_body']['accessToken'];
      // final String refreshToken = body['data_body']['refreshToken'];
      return dataBody; // accessToken, refreshToken 반환
    } else {
      debugPrint(
          'getMarker res not 200 ################################################');
      print(jsonDecode(utf8.decode(res.bodyBytes)));
      debugPrint(
          'getMarker res not 200 ################################################');

      return null;
    }
  }

  // 소곤 상세 조회 요청 api
  Future<Map<String, dynamic>?> getSogonDetail(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    print("############ get Token, id ###########");
    // print(jsonEncode(location.toJson()));
    print('$accessToken, $id');
    print("############ get Token: id ###########");

    final res = await http.get(
      Uri.parse('$baseUrl/api/v1/sogons/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
    );
    if (res.statusCode == 200) {
      final String body = utf8.decode(res.bodyBytes);
      final Map<String, dynamic> dataBody =
          jsonDecode(body)['data_body'] as Map<String, dynamic>;
      debugPrint(
          'getSogonDetail res 200 ################################################');
      print(body);
      print(dataBody);
      debugPrint(
          'getSogonDetail res 200 ################################################');

      // final List dataBody = body['data_body'];
      // final String accessToken = body['data_body']['accessToken'];
      // final String refreshToken = body['data_body']['refreshToken'];
      return dataBody; // accessToken, refreshToken 반환
    } else {
      debugPrint(
          'getSogonDetail res not 200 ################################################');
      print(utf8.decode(res.bodyBytes));

      // print(jsonDecode(res.body));
      debugPrint(
          'getSogonDetail res not 200 ################################################');

      return null;
    }
  }

  // 보유 소콘 조회
  Future<Map<String, dynamic>?> getSocons() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final res = await http.get(
      Uri.parse('$baseUrl/api/v1/socons/book'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
    );
    if (res.statusCode == 200) {
      final String body = utf8.decode(res.bodyBytes);
      final Map<String, dynamic> dataBody =
          jsonDecode(body)['data_body'] as Map<String, dynamic>;
      debugPrint(
          'getSocons res 200 ################################################');
      print(body);
      print(dataBody);
      debugPrint(
          'getSocons res 200 ################################################');

      // final List dataBody = body['data_body'];
      // final String accessToken = body['data_body']['accessToken'];
      // final String refreshToken = body['data_body']['refreshToken'];
      return dataBody; // accessToken, refreshToken 반환
    } else {
      debugPrint(
          'getSocons res not 200 ################################################');
      print(utf8.decode(res.bodyBytes));

      // print(jsonDecode(res.body));
      debugPrint(
          'getSocons res not 200 ################################################');

      return null;
    }
  }

//
}
