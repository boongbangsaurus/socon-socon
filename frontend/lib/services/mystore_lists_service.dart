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
    print('............................');
    print(response.statusCode);
    print('............................');

    if (response.statusCode == 200) {
      final String body = utf8.decode(response.bodyBytes);
      final decodedBody = jsonDecode(body);
      debugPrint(body);    // {"data_header":{"success_code":0,"result_code":"200 OK","result_message":null},"data_body":[{"id":23,"name":"늘솜꼬마김밥2","category":"음식점","image":"https://cataas.com/cat","created_at":"2024-03-27"},{"id":24,"name":"늘솜꼬마김밥","category":"음식점","image":"https://cataas.com/cat","created_at":"2024-03-31"},{"id":28,"name":"asdfasg","category":"미용","image":"","created_at":"2024-04-03"},{"id":29,"name":"weewe","category":"미용","image":"/data/user/0/site.boongbang.socon/cache/5f1b0254-41d1-4ff8-97c6-b627cc3b7b3d/1000000034.jpg","created_at":"2024-04-03"},{"id":30,"name":"ruyiryi","category":"미용","image":"/data/user/0/site.boongbang.socon/cache/5f1b0254-41d1-4ff8-97c6-b627cc3b7b3d/1000000034.jpg","created_at":"2024-04-03"},{"id":31,"name":"상호명\t","category":"음식점","image":"/data/user/0/site.boongbang.socon/cache/4f9413d0-7d01-43c5-b5f5-be2378ffe942/1000000034.jpg","created_at":"2024-04-03"}]}
      debugPrint(
          '###########MystoreListsService res 200 ################################################');
      final List<dynamic> dataBody = decodedBody['data_body'];
      debugPrint(
          'MystoreListsService res 200 ################################################');
      print(dataBody);   // [{id: 23, name: 늘솜꼬마김밥2, category: 음식점, image: https://cataas.com/cat, created_at: 2024-03-27}, {id: 24, name: 늘솜꼬마김밥, category: 음식점, image: https://cataas.com/cat, created_at: 2024-03-31}, {id: 28, name: asdfasg, category: 미용, image: , created_at: 2024-04-03}, {id: 29, name: weewe, category: 미용, image: /data/user/0/site.boongbang.socon/cache/5f1b0254-41d1-4ff8-97c6-b627cc3b7b3d/1000000034.jpg, created_at: 2024-04-03}, {id: 30, name: ruyiryi, category: 미용, image: /data/user/0/site.boongbang.socon/cache/5f1b0254-41d1-4ff8-97c6-b627cc3b7b3d/1000000034.jpg, created_at: 2024-04-03}, {id: 31, name: 상호명	, category: 음식점, image: /data/user/0/site.boongbang.socon/cache/4f9413d0-7d01-43c5-b5f5-be2378ffe942/1000000034.jpg, created_at: 2024-04-03}]
      return dataBody;
      // final List<dynamic> decodedBody = jsonDecode(utf8.decode(response.bodyBytes))['data_body'];
      // debugPrint('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
      // debugPrint(decodedBody as String?);
      // debugPrint('zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');
      // // 데이터를 MyStoreListModel 리스트로 변환
      // return decodedBody.map((data) => MyStoreListModel.fromJson(data)).toList();
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


