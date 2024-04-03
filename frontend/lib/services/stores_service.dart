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
    var params = {
      "content": "오소유",
      // "lat": 37.1820489,
      // "lng": 131.7718627,
      "searchType": "name", //상호명 : name, 카테고리 : category,  도로명 주소 : address
      "sort": "distance", //최단거리 : distance, 가나다 : name,
      "isFavoriteSearch": true,
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
      params["long"] = pLong;
      print("검색 params $params");
      final response = await ApiUtils.postDataWithToken(
          '/api/v1/search/detail', params
         );



      final Map<String, dynamic> responseData = jsonDecode(response);
      print("검색 성공 $response");
      final List<Store> responseBody = responseData['data_body'];
      // final int successCode = responseData['data_header']['success_code'];
      if(responseBody.isEmpty ){
        return null;
      }
      return responseBody;
    } catch (error) {
      print('검색 실패 $error');
      // return false;
    }
  }
}
