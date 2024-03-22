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

  void setBusinessHours(List<BusinessHour>? value) {
    _registerModel.businessHours = value;
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