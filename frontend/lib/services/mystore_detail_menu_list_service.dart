import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


// 내 점포 상세 조회 (발행 소콘 목록) get
class MystoreMenuService {
  final String baseUrl = 'http://j10c207.p.ssafy.io:8000'; // 통신 url


  // 점포 조회 디테일 요청 - 메뉴관리
  Future<Map<String, dynamic>?> getMystoreMenuLists(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final res = await http.get(
      Uri.parse('$baseUrl/api/v1/stores/$id/manage/info'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
    );

    if (res.statusCode == 200) {
      final String body = utf8.decode(res.bodyBytes);
      final Map<String, dynamic> dataBody =
      jsonDecode(body)['data_body']['items'] as Map<String, dynamic>;
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



  // 점포 조회 디테일 요청 - 발행소콘
  Future<Map<String, dynamic>?> getMystoreRegisterMenuLists(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

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

}

