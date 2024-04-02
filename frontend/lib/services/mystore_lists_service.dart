import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socon/models/mystore_lists_model.dart';

/// [MystoreListsService]
/// 백과 통신하기 위한 class..

class MystoreListsService {
  final String baseUrl = 'http://j10c207.p.ssafy.io:8000'; // 통신 url
  // final String baseUrl = 'https://6739-61-84-244-233.ngrok-free.app';

  Future<List> getMystoreLists() async {
    final url = Uri.parse('$baseUrl/api/v1/stores');
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    debugPrint('vvvvvvvvvvvv');
    // print(myStoreListModel.toJson());

    final response = await http.get(url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      final String body = utf8.decode(response.bodyBytes);
      final decodedBody = jsonDecode(body);
      debugPrint(body);
      debugPrint(
          '###########MystoreListsService res 200 ################################################');
      final List<dynamic> dataBody = decodedBody['data_body'];
      debugPrint(
          'MystoreListsService res 200 ################################################');
      print(dataBody);
    //   print(dataBody);
    //   debugPrint(
    //       'MystoreListsService res 200 ################################################');
    //
    //   // final List dataBody = body['data_body'];
    //   // final String accessToken = body['data_body']['accessToken'];
    //   // final String refreshToken = body['data_body']['refreshToken'];
      return dataBody; // accessToken, refreshToken 반환
    } else {
    //   debugPrint(
    //       'MystoreListsService res not 200 ################################################');
    //   print(utf8.decode(response.bodyBytes));
    //
    //   // print(jsonDecode(res.body));
    //   debugPrint(
    //       'MystoreListsService res not 200 ################################################');
    //
      return [];
    }
  }
}


