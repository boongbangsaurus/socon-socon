import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class RegisterModel {
  String? representative;
  String? registration_number;
  String? address;
  String? name;
  String? phone_number;
  String? category;
  double? lat;
  double? lng;
  String? introduction;


  RegisterModel({
    this.representative,
    this.registration_number,
    this.address,
    this.name,
    this.phone_number,
    this.category,
    this.lat,
    this.lng,
    this.introduction

  });

}