import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'register_model.dart';


class RegisterViewModel extends ChangeNotifier {
  final RegisterModel _registerModel = RegisterModel();
  bool _isFocused = false;

  // Getters
  String get representative => _registerModel.representative;
  String get registrationNumber => _registerModel.registration_number;
  String get address => _registerModel.address;
  String get name => _registerModel.name;
  String get phoneNumber => _registerModel.phone_number;
  String get category => _registerModel.category;
  double get lat => _registerModel.lat;
  double get lng => _registerModel.lng;
  String get introduction => _registerModel.introduction;
  bool get isFocused => _isFocused;

  // Setters
  void setRepresentative(String value) {
    _registerModel.setRepresentative(value);
    notifyListeners();
  }

  void setRegistrationNumber(String value) {
    _registerModel.setRegistrationNumber(value);
    notifyListeners();
  }

  void setAddress(String value) {
    _registerModel.setAddress(value);
    notifyListeners();
  }

  void setName(String value) {
    _registerModel.setName(value);
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _registerModel.setPhoneNumber(value);
    notifyListeners();
  }

  void setCategory(String value) {
    _registerModel.setCategory(value);
    notifyListeners();
  }

  void setLat(double value) {
    _registerModel.setLat(value);
    notifyListeners();
  }

  void setLng(double value) {
    _registerModel.setLng(value);
    notifyListeners();
  }

  void setIntroduction(String value) {
    _registerModel.setIntroduction(value);
    notifyListeners();
  }

  void setFocused(bool value) {
    _isFocused = value;
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