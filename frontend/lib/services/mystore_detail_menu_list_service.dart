import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


// 내 점포 상세 조회 (발행 소콘 목록) get
class MystoreMenuService {
  final String baseUrl = 'http://j10c207.p.ssafy.io:8000'; // 통신 url


  // 점포 조회 디테일 요청 - 메뉴관리
  Future<List<dynamic>?> getMystoreMenuLists(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/stores/$id/manage/info'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final String body = utf8.decode(response.bodyBytes);
      final decodedBody = jsonDecode(body);
      // debugPrint(body);
      // {"data_header":{"success_code":0,"result_code":"200 OK","result_message":null},"data_body":[{"id":23,"name":"늘솜꼬마김밥2","category":"음식점","image":"https://cataas.com/cat","created_at":"2024-03-27"},{"id":24,"name":"늘솜꼬마김밥","category":"음식점","image":"https://cataas.com/cat","created_at":"2024-03-31"},{"id":28,"name":"asdfasg","category":"미용","image":"","created_at":"2024-04-03"},{"id":29,"name":"weewe","category":"미용","image":"/data/user/0/site.boongbang.socon/cache/5f1b0254-41d1-4ff8-97c6-b627cc3b7b3d/1000000034.jpg","created_at":"2024-04-03"},{"id":30,"name":"ruyiryi","category":"미용","image":"/data/user/0/site.boongbang.socon/cache/5f1b0254-41d1-4ff8-97c6-b627cc3b7b3d/1000000034.jpg","created_at":"2024-04-03"},{"id":31,"name":"상호명\t","category":"음식점","image":"/data/user/0/site.boongbang.socon/cache/4f9413d0-7d01-43c5-b5f5-be2378ffe942/1000000034.jpg","created_at":"2024-04-03"}]}
      final Map<String, dynamic> dataBody = decodedBody['data_body'];
      // final Map<String, List<Map<String, dynamic>>> dataBody = decodedBody['data_body'];

      debugPrint(
          '###########내점포상세 메뉴리스트 res 200 ################################################');
      print(dataBody);   // [{id: 23, name: 늘솜꼬마김밥2, category: 음식점, image: https://cataas.com/cat, created_at: 2024-03-27}, {id: 24, name: 늘솜꼬마김밥, category: 음식점, image: https://cataas.com/cat, created_at: 2024-03-31}, {id: 28, name: asdfasg, category: 미용, image: , created_at: 2024-04-03}, {id: 29, name: weewe, category: 미용, image: /data/user/0/site.boongbang.socon/cache/5f1b0254-41d1-4ff8-97c6-b627cc3b7b3d/1000000034.jpg, created_at: 2024-04-03}, {id: 30, name: ruyiryi, category: 미용, image: /data/user/0/site.boongbang.socon/cache/5f1b0254-41d1-4ff8-97c6-b627cc3b7b3d/1000000034.jpg, created_at: 2024-04-03}, {id: 31, name: 상호명	, category: 음식점, image: /data/user/0/site.boongbang.socon/cache/4f9413d0-7d01-43c5-b5f5-be2378ffe942/1000000034.jpg, created_at: 2024-04-03}]
      debugPrint(
          '내점포상세 메뉴리스트 res 200 ################################################');
      return dataBody['items'];

    } else {
      debugPrint(
          '내점포상세 메뉴리스트 res not 200 ################################################');
      print(utf8.decode(response.bodyBytes));
      debugPrint(
          '내점포상세 메뉴리스트 res not 200 ################################################');

      return null;
    }
  }



  // 점포 조회 디테일 요청 - 발행소콘
  Future<List<dynamic>?> getMystoreRegisterMenuLists(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/stores/$id/manage/info'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final String body = utf8.decode(response.bodyBytes);
      final decodedBody = jsonDecode(body);
      final Map<String, dynamic> dataBody = decodedBody['data_body'];

      debugPrint(
          '###########내발행소콘 메뉴리스트 res 200 ################################################');
      print(dataBody);   // [{id: 23, name: 늘솜꼬마김밥2, category: 음식점, image: https://cataas.com/cat, created_at: 2024-03-27}, {id: 24, name: 늘솜꼬마김밥, category: 음식점, image: https://cataas.com/cat, created_at: 2024-03-31}, {id: 28, name: asdfasg, category: 미용, image: , created_at: 2024-04-03}, {id: 29, name: weewe, category: 미용, image: /data/user/0/site.boongbang.socon/cache/5f1b0254-41d1-4ff8-97c6-b627cc3b7b3d/1000000034.jpg, created_at: 2024-04-03}, {id: 30, name: ruyiryi, category: 미용, image: /data/user/0/site.boongbang.socon/cache/5f1b0254-41d1-4ff8-97c6-b627cc3b7b3d/1000000034.jpg, created_at: 2024-04-03}, {id: 31, name: 상호명	, category: 음식점, image: /data/user/0/site.boongbang.socon/cache/4f9413d0-7d01-43c5-b5f5-be2378ffe942/1000000034.jpg, created_at: 2024-04-03}]
      debugPrint(
          '내발행소콘 메뉴리스트 res 200 ################################################');
      return dataBody['issues'];

    } else {
      debugPrint(
          '내발행소콘 메뉴리스트 res not 200 ################################################');
      print(utf8.decode(response.bodyBytes));
      debugPrint(
          '내발행소콘 메뉴리스트 res not 200 ################################################');

      return null;
    }
  }



  // 가게 상세조회
  Future<List<dynamic>?> getStoreDetailInfos(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    final response = await http.get(
      Uri.parse('$baseUrl/api/v1/stores/$id/info'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final String body = utf8.decode(response.bodyBytes);
      final decodedBody = jsonDecode(body);
      final Map<String, dynamic> dataBody = decodedBody['data_body'];

      debugPrint(
          '###########내발행소콘 메뉴리스트 res 200 ################################################');
      print(dataBody['store']);   // [{id: 23, name: 늘솜꼬마김밥2, category: 음식점, image: https://cataas.com/cat, created_at: 2024-03-27}, {id: 24, name: 늘솜꼬마김밥, category: 음식점, image: https://cataas.com/cat, created_at: 2024-03-31}, {id: 28, name: asdfasg, category: 미용, image: , created_at: 2024-04-03}, {id: 29, name: weewe, category: 미용, image: /data/user/0/site.boongbang.socon/cache/5f1b0254-41d1-4ff8-97c6-b627cc3b7b3d/1000000034.jpg, created_at: 2024-04-03}, {id: 30, name: ruyiryi, category: 미용, image: /data/user/0/site.boongbang.socon/cache/5f1b0254-41d1-4ff8-97c6-b627cc3b7b3d/1000000034.jpg, created_at: 2024-04-03}, {id: 31, name: 상호명	, category: 음식점, image: /data/user/0/site.boongbang.socon/cache/4f9413d0-7d01-43c5-b5f5-be2378ffe942/1000000034.jpg, created_at: 2024-04-03}]
      debugPrint(
          '내발행소콘 메뉴리스트 res 200 ################################################');

      return dataBody['store'];

    } else {
      debugPrint(
          '내발행소콘 메뉴리스트 res not 200 ################################################');
      print(utf8.decode(response.bodyBytes));
      debugPrint(
          '내발행소콘 메뉴리스트 res not 200 ################################################');

      return null;
    }
  }

}

