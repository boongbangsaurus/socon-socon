import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:socon/models/location.dart';
import 'package:socon/models/sogon_register.dart';

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
  Future<Map<String, dynamic>?> getSogonDetail(String id) async {
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
      print(dataBody);
      debugPrint(
          'getSogonDetail res 200 ################################################');

      return dataBody;
    } else {
      debugPrint(
          'getSogonDetail res not 200 ################################################');
      print(utf8.decode(res.bodyBytes));
      debugPrint(
          'getSogonDetail res not 200 ################################################');

      return null;
    }
  }

  // 보유 소콘 조회
  Future<List<dynamic>> getSocons() async {
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
      print(dataBody['usable'].runtimeType);
      debugPrint(
          'getSocons res 200 ################################################');

      // final List dataBody = body['data_body'];
      // final String accessToken = body['data_body']['accessToken'];
      // final String refreshToken = body['data_body']['refreshToken'];
      return dataBody['usable']; // accessToken, refreshToken 반환
    } else {
      debugPrint(
          'getSocons res not 200 ################################################');
      print(utf8.decode(res.bodyBytes));

      // print(jsonDecode(res.body));
      debugPrint(
          'getSocons res not 200 ################################################');

      return [];
    }
  }

  // 소곤 등록 POST api 요청
  Future<bool> sogonRegister(SogonRegister sogonRegister) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    print("############ get Token, local: getMarker ###########");
    print(jsonEncode(sogonRegister.toJson()));
    print(accessToken);
    print("############ get Token: getMarker ###########");

    final res = await http.post(
      Uri.parse('$baseUrl/api/v1/sogons'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(sogonRegister.toJson()),
    );
    if (res.statusCode == 201) {
      final String body = utf8.decode(res.bodyBytes);
      debugPrint(
          'sogonRegister res 201 ################################################');
      print(body);
      debugPrint(
          'sogonRegister res 201 ################################################');

      return true;
    } else {
      debugPrint(
          'sogonRegister res not 201 ################################################');
      print(jsonDecode(utf8.decode(res.bodyBytes)));
      debugPrint(
          'sogonRegister res not 201 ################################################');
      return false;
    }
  }

  // 댓글 등록 POST api 요청
  Future<bool> commentRegister(String sogon_id, String comment) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    print("############ sogon_id, comment ###########");
    print('$sogon_id, $comment');
    print("############ sogon_id, comment ###########");

    final res = await http.post(
      Uri.parse('$baseUrl/api/v1/sogons/$sogon_id/comment'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({'content': comment}),
    );
    if (res.statusCode == 200) {
      final String body = utf8.decode(res.bodyBytes);
      debugPrint(
          'commentRegister res 201 ################################################');
      print(body);
      debugPrint(
          'commentRegister res 201 ################################################');

      return true;
    } else {
      debugPrint(
          'commentRegister res not 201 ################################################');
      print(jsonDecode(utf8.decode(res.bodyBytes)));
      debugPrint(
          'commentRegister res not 201 ################################################');
      return false;
    }
  }

  // 소곤 댓글 채택 GET요청
  Future<bool> setPicked(String sogon_id, String comment_id) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final res = await http.get(
      Uri.parse('$baseUrl/api/v1/sogons/$sogon_id/comment/$comment_id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
    );
    if (res.statusCode == 200) {
      debugPrint(
          'setPicked res 200 ################################################');
      return true;
    } else {
      debugPrint(
          'setPicked res not 200 ################################################');
      print(utf8.decode(res.bodyBytes));
      debugPrint(
          'setPicked res not 200 ################################################');

      return false;
    }
  }

  // 소곤 firebase storage uid 생성 GET 요청
  Future<String> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    final res = await http.get(
      Uri.parse('$baseUrl/api/v1/notification/fcm/authenticate'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
    );
    final String body = utf8.decode(res.bodyBytes);
    if (res.statusCode == 200) {
      debugPrint(
          'getUid res 200 ################################################');
      return body;
    } else {
      debugPrint(
          'getUid res not 200 ################################################');
      print(utf8.decode(res.bodyBytes));
      debugPrint(
          'getUid res not 200 ################################################');

      return body;
    }
  }
}
