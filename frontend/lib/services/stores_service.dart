import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:socon/models/business_owner.dart';
import 'package:socon/models/place_params.dart';
import 'package:socon/models/search_params.dart';
import 'package:socon/models/store.dart';
import 'package:socon/views/screens/bossVerification/boss_verification.dart';
import 'package:socon/views/screens/myStore/search_address.dart';

import '../utils/api/api_utils.dart';
import '../utils/api/users/fetch_boss_data.dart';
import 'package:geolocator/geolocator.dart';

class StoresService {
  Future<List<Store>?> searchStores() async {
    // Store params = Store(
    //     {
    //       "content": "",
    //       // "lat": 37.1820489,
    //       // "lng": 131.7718627,
    //       "searchType": "name", //상호명 : name, 카테고리 : category,  도로명 주소 : address
    //       "sort": "distance", //최단거리 : distance, 가나다 : name,
    //       "isFavoriteSearch": false,
    //       "page": 0, //offset,
    //       "size": 10, //default
    //     }, storeId: null
    // );

    late double pLat;
    late double pLng;

    // String jsonParams = jsonEncode(params);
    // print(jsonParams);

    try {
      // 1. 위치 검색
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      pLat = position.latitude;
      pLng = position.longitude;

      SearchParams _searchParams = SearchParams(
          content: "",
          lat: pLat,
          lng: pLng,
          searchType: "name",
          sort: "distance",
          isFavoriteSearch: false,
          page: 0,
          size: 10);

      print("검색 params $_searchParams");
      final response = await ApiUtils.postDataWithToken(
          '/api/v1/search/detail', _searchParams);
      print('[service] $response');
      // List<Store> stores = [];
      // print(
      // "바껴주세요 ${List<Map<String, dynamic>>.from(response).map((item) => Store.fromJson(item)).toList()}");
      // print("[service] $response  ${response.runtimeType}");

      // final Map<String, dynamic> responseData = jsonDecode(response);
      // final int successCode = responseData['data_header']['success_code'];
      print("---------------------");
      // List<Map<String, dynamic>>.from(response).forEach((item) {
      //   print("item!!! $item --------------------   itemType ${item.runtimeType}");
      // });
      List<Store> stores = List<Map<String, dynamic>>.from(response).map((item) {
        // 'Store.fromJson' 생성자를 사용하여 각 아이템을 'Store' 객체로 변환
        print(Store.fromJson(item));


        return Store.fromJson(item);
      }).toList();

      print("[service] stores $stores");

      // print("type ________________ ${responseData.runtimeType}");
      // print(successCode);
      // print("[service] ${response.runtimeType}");
      // print("[service] response ${jsonEncode(response)}");
      // print("[service] ${jsonEncode(response).runtimeType}");

      // response.map<Store>((item) => Store.fromJson(item)).toList();
      // print("[service] stores $stores");

      return stores;
    } catch (error) {
      print('[service] 검색 실패 $error');
      return null;
      // return false;
    }
  }
}
