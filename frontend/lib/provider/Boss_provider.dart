import 'package:flutter/material.dart';

class BossProvider extends ChangeNotifier {
  String owner = ""; // 대표자 성함
  // String registrationNumberId = ""; // 아이디
  String registrationNumber = ""; // 사업자 등록 번호
  String registrationAddress = ""; // 등록 주소
  String postCode = '-';
  String address = '-';
  String latitude = '-';
  String longitude = '-';

  // String kakaoLatitude = '-';
  // String kakaoLongitude = '-';

  void setBoss({
    String owner = "",
    String registrationNumber = "",
    String registrationAddress = "",
    String postCode = "",
    String address = "",
    String latitude = "",
    String longitude = "",
    // String kakaoLatitude = "",
    // String kakaoLongitude = "",
  }) {
    this.owner = owner;
    this.registrationNumber = registrationNumber;
    this.registrationAddress = registrationAddress;
    this.postCode = postCode;
    this.address = address;
    this.latitude = latitude;
    this.longitude = longitude;
    // this.kakaoLatitude = kakaoLatitude;
    // this.kakaoLongitude = kakaoLongitude;

    // 상태가 변경되었음을 Provider에 알립니다.
    notifyListeners();
  }
}
