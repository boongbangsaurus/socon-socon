import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {

  String postCode = '';
  String address = '';
  String latitude = '';
  String longitude = '';
  String kakaoLatitude = '';
  String kakaoLongitude = '';

  void setAddress({
    required String postCode,
    required String address,
    required String latitude,
    required String longitude,
    String kakaoLatitude = "",
    String kakaoLongitude = "",
  }) {
    this.postCode = postCode;
    this.address = address;
    this.latitude = latitude;
    this.longitude = longitude;
    this.kakaoLatitude = kakaoLatitude;
    this.kakaoLongitude = kakaoLongitude;

    // 상태가 변경되었음을 Provider에 알립니다.
    notifyListeners();
  }
}
