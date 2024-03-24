import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:socon/models/store_register_model.dart';


class RegisterViewModel extends ChangeNotifier {
  final RegisterModel _registerModel = RegisterModel();


  // Getters
  // String? get representative => _registerModel.representative;
  String? get registrationNumber => _registerModel.registrationNumber;
  String? get address => _registerModel.address;
  String? get name => _registerModel.name;
  String? get phoneNumber => _registerModel.phoneNumber;
  String? get category => _registerModel.category;
  double? get lat => _registerModel.lat;
  double? get lng => _registerModel.lng;
  String? get introduction => _registerModel.introduction;
  String? get imgUrl => _registerModel.imgUrl;
  List<BusinessHour>? get businessHours => _registerModel.businessHours;


  // Setters
  // void setRepresentative(String value) {
  //   _registerModel.representative = value;
  //   notifyListeners();
  // }

  void setRegistrationNumber(String value) {
    _registerModel.registrationNumber = value;
    notifyListeners();
  }

  void setAddress(String value) {
    _registerModel.address = value;
    notifyListeners();
  }

  void setName(String value) {
    _registerModel.name = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _registerModel.phoneNumber = value;
    notifyListeners();
  }

  void setCategory(String value) {
    _registerModel.category = value;
    notifyListeners();
  }

  void setLat(double value) {
    _registerModel.lat = value;
    notifyListeners();
  }

  void setLng(double value) {
    _registerModel.lng = value;
    notifyListeners();
  }

  void setIntroduction(String value) {
    _registerModel.introduction = value;
    notifyListeners();
  }

  void setImgUrl(String? value) {
    _registerModel.imgUrl = value;
    notifyListeners();
  }

  void updateBusinessHour(String day, {String? openAt, String? closeAt, bool? isWorking, bool? breakTime, String? breaktimeStart, String? breaktimeEnd}) {
    if (_registerModel.businessHours == null) {
      _registerModel.businessHours = [];
    }
    // 해당 요일의 BusinessHour 찾기
    var businessHour = _registerModel.businessHours!.firstWhere(
          (bh) => bh.day == day,
      orElse: () => BusinessHour(day: day, isWorking: false, openAt: null, closeAt: null),
    );

    // 찾은 BusinessHour 업데이트
    if (day != null) businessHour.day = day;
    if (openAt != null) businessHour.openAt = openAt;
    if (closeAt != null) businessHour.closeAt = closeAt;
    if (isWorking != null) businessHour.isWorking = isWorking;
    if (breakTime != null) businessHour.breakTime = breakTime;
    if (breaktimeStart != null) businessHour.breaktimeStart = breaktimeStart;
    if (breaktimeEnd != null) businessHour.breaktimeEnd = breaktimeEnd;

    // 만약 새로운 요일이라면 리스트에 추가
    if (!_registerModel.businessHours!.contains(businessHour)) {
      _registerModel.businessHours!.add(businessHour);
    }

    notifyListeners();
  }



  void register() {
    // 디버그 프린트
    debugPrint('Registering with the following details:');
    debugPrint('Name: ${_registerModel.name}');
    debugPrint('Address: ${_registerModel.address}');
    debugPrint('Phone Number: ${_registerModel.phoneNumber}');

  }
}