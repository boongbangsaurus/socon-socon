import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:socon/models/business_owner.dart';
import 'package:socon/models/place_params.dart';
import 'package:socon/models/store.dart';
import 'package:socon/views/screens/bossVerification/boss_verification.dart';

import '../utils/api/api_utils.dart';
import '../utils/api/users/fetch_boss_data.dart';
import 'package:geolocator/geolocator.dart';

class StoresService {
  Future<List<Store>?> searchStores() async {
    Map<String, dynamic> params = {
      "content": "",
      // "lat": 37.1820489,
      // "lng": 131.7718627,
      "searchType": "name", //상호명 : name, 카테고리 : category,  도로명 주소 : address
      "sort": "distance", //최단거리 : distance, 가나다 : name,
      "isFavoriteSearch": false,
      "page": 0, //offset,
      "size": 10, //default
    };

    late double pLat;
    late double pLong;

    // String jsonParams = jsonEncode(params);
    // print(jsonParams);

    try {
      // 1. 위치 검색
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      pLat = position.latitude;
      pLong = position.longitude;

      params["lat"] = pLat;
      params["lng"] = pLong;
      print("검색 params $params");
      final List<dynamic> response =
          await ApiUtils.postDataWithToken('/api/v1/search/detail', params);

      if (response == null) {
        print('API 응답이 null입니다.');
        return null;
      }else{
        print(response);
      }

      final List<Store> responseData = response.map((item) => Store.fromJson(item)).toList();
      // final List<Store> responseData = response.map((item) => Store.fromJson(item)).toList();
      print("[service] response $responseData}");
      return responseData;
      // if (responseData.isNotEmpty) {
      //   return responseData;
      // } else {
      //   return [];
      // }

    } catch (error) {
      print('검색 실패 $error');
      return null;
      // return false;
    }
  }
}
