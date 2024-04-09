import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:socon/models/user.dart';
import 'package:socon/services/notifications/firebase_messaging_service.dart';
import 'package:socon/utils/api/api_utils.dart';

/// [AuthService]
/// 백과 API 통신하기 위한 Class
class AuthService {
  final String baseUrl = 'http://j10c207.p.ssafy.io:8000'; // 통신 url
  FirebaseMessagingService _firebaseMessagingService =
  FirebaseMessagingService();

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
      debugPrint(
          'signUp not res 200 ################################################');
      print(jsonDecode(res.body));
      debugPrint(
          'signUp not res 200 ################################################');

      return false;
    }
  }

  // 로그인 요청 api
  Future<List?> signIn(User user) async {
    var fcmToken = await _firebaseMessagingService.getFcmToken();
    var userData = user.toJsonSignIn();
    userData["fcmToken"] = fcmToken;

    if (kDebugMode) {
      print("${userData} 유저 데이터 fcmToken 포함");
    }

    final res = await http.post(
      Uri.parse('$baseUrl/api/v1/members/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userData),
    );

    if (res.statusCode == 200) {
      debugPrint(
          'signIn res 200 ################################################');
      print(jsonDecode(utf8.decode(res.bodyBytes)));
      debugPrint(
          'signIn res 200 ################################################');

      final body = jsonDecode(utf8.decode(res.bodyBytes));
      final String accessToken = body['data_body']['accessToken'];
      final String refreshToken = body['data_body']['refreshToken'];
      final String nickname = body['data_body']['nickname'];
      return [
        accessToken,
        refreshToken,
        nickname
      ]; // accessToken, refreshToken 반환
    } else {
      debugPrint(
          'signIn res not 200 ################################################');
      print(jsonDecode(res.body));
      debugPrint(
          'signIn res not 200 ################################################');

      return null;
    }
  }

  Future<void> getUserInfo() async {
    final response = await ApiUtils.getDataWithToken("/api/v1/members/mypage");

    print("사용자 정보 ${jsonDecode(response)}");

    final data = jsonDecode(response);
  }
}
