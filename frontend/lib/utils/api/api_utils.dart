import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiUtils {
  static final String baseUrl = 'http://j10c207.p.ssafy.io:8000';
  // static final String baseUrl = 'https://f7a9-121-178-98-30.ngrok-free.app';
  static Map<String, String>? _customHeader; // 토큰을 한 번만 읽어오기 위해 변수를 추가

  static Future<void> _loadHeader() async {
    _customHeader = {
      'Accept': 'application/json',
      "Authorization": "*/*",
      'Content-Type': 'application/json',
    };
  }

  static Future<void> _loadHeaderWithToken() async {
    if (_customHeader == null) {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      _customHeader = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': "application/json",
      };
    }
  }

  static Future<String> getData(String endPoint) async {
    await _loadHeader(); // 헤더 로드
    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: _customHeader,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('통신 실패: ${response.body}');
    }
  }

  static Future<String> getDataWithToken(String endPoint) async {
    await _loadHeaderWithToken(); // 헤더 로드
    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: _customHeader,
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('통신 실패: ${response.body}');
    }
  }

  static FutureOr<dynamic> postDataWithToken(String endPoint, dynamic data ) async {
    print(jsonEncode(data));
    await _loadHeaderWithToken(); // 헤더 로드
    final response = await http.post(
      Uri.parse('$baseUrl$endPoint'),
      headers: _customHeader,
      body: jsonEncode(data),
      // body: data,
    );
    if (response.statusCode == 200) {
      print("hihi");
      print(jsonDecode(response.body)["data_body"]);
      return jsonDecode(response.body)["data_body"];
    } else {
      throw Exception('통신 실패: ${jsonDecode(response.body)}');
    }
  }


  static Future<String> postVerifyBoss(String endPoint, dynamic data ) async {
    await _loadHeaderWithToken(); // 헤더 로드
    print("사업자 등록증 검증 url 'https://api.odcloud.kr/api/nts-businessman/v1/status$endPoint'");
    final response = await http.post(
      Uri.parse('https://api.odcloud.kr/api/nts-businessman/v1/status$endPoint'),
      headers: _customHeader,
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('통신 실패: ${response.body}');
    }
  }
}
