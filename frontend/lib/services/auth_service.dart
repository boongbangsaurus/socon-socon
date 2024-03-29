import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:socon/models/user.dart';

/// [AuthService]
/// 백과 API 통신하기 위한 Class
class AuthService {
  final String baseUrl = 'http://j10c207.p.ssafy.io:8000'; // 통신 url

  // 회원가입 요청 api
  Future<bool> signUp(User user) async {
    // print(jsonEncode(user.toJson()));
    final res = await http.post(
      Uri.parse('$baseUrl/api/v1/members'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      print(jsonDecode(res.body));
      return false;
    }
  }

  // 로그인 요청 api
  Future<List?> signIn(User user) async {
    print(jsonEncode(user.toJsonSignIn()));
    final res = await http.post(
      Uri.parse('$baseUrl/api/v1/members/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJsonSignIn()),
    );

    if (res.statusCode == 200) {
      debugPrint('res 200 ################################################');
      debugPrint(jsonDecode(res.body));
      debugPrint('################################################');

      final body = jsonDecode(res.body);
      final String accessToken = body['data_body']['accessToken'];
      final String refreshToken = body['data_body']['refreshToken'];
      return [accessToken, refreshToken]; // accessToken, refreshToken 반환
    } else {
      debugPrint(
          'res not 200 ################################################');
      print(jsonDecode(res.body));
      debugPrint('################################################');

      return null;
    }
  }
}
