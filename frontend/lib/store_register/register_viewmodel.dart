import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'register_model.dart';


class RegisterViewModel extends ChangeNotifier {
  final RegisterModel _registerModel = RegisterModel();


  // Getters
  String? get representative => _registerModel.representative;
  String? get registration_number => _registerModel.registration_number;
  String? get address => _registerModel.address;
  String? get name => _registerModel.name;
  String? get phone_number => _registerModel.phone_number;
  String? get category => _registerModel.category;
  double? get lat => _registerModel.lat;
  double? get lng => _registerModel.lng;
  String? get introduction => _registerModel.introduction;


  // Setters
  void setRepresentative(String value) {
    _registerModel.representative = value;
    notifyListeners();
  }

  void setRegistrationNumber(String value) {
    _registerModel.registration_number = value;
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
    _registerModel.phone_number = value;
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


  void register() {
    // 디버그 프린트
    debugPrint('Registering with the following details:');
    debugPrint('Name: ${_registerModel.name}');
    debugPrint('Address: ${_registerModel.address}');
    debugPrint('Phone Number: ${_registerModel.phone_number}');

  }
}