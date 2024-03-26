import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:socon/models/user.dart';

/// [AuthService]
/// 백과 API 통신하기 위한 Class
class AuthService {
  final String baseUrl = 'http://'; // 통신 url

  // 회원가입 요청 api
  Future<bool> signUp(User user) async {
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
      return false;
    }
  }
}
