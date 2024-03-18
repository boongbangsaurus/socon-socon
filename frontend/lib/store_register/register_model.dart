import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class RegisterModel with ChangeNotifier{
  String _representative = '';
  String _registration_number = '';
  String _address = '';
  String _name = '';
  String _phone_number = '';
  String _category = '';
  double _lat = 0.0;
  double _lng = 0.0;
  String _introduction = '';

  // Getters
  String get representative => _representative;
  String get registration_number => _registration_number;
  String get address => _address;
  String get name => _name;
  String get phone_number => _phone_number;
  String get category => _category;
  double get lat => _lat;
  double get lng => _lng;
  String get introduction => _introduction;

  // Setters
  void setRepresentative(String value) {
    _representative = value;
  }

  void setRegistrationNumber(String value) {
    _registration_number = value;
  }

  void setAddress(String value) {
    _address = value;
  }

  void setName(String value) {
    _name = value;
  }

  void setPhoneNumber(String value) {
    _phone_number = value;
  }

  void setCategory(String value) {
    _category = value;
  }

  void setLat(double value) {
    _lat = value;
  }

  void setLng(double value) {
    _lng = value;
  }

  void setIntroduction(String value) {
    _introduction = value;
  }
}


