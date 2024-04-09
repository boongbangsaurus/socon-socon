import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socon/services/auth_service.dart';

import '../utils/api/api_utils.dart';

class MyInfoProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  Map<String, dynamic> userData = {};

  Map<String, dynamic> getUserInfo() {
    _fetchUserInfo();

    return userData;
  }

  void _fetchUserInfo() async {
    final response = await ApiUtils.getDataWithToken("/api/v1/members/mypage");
    final data = jsonDecode(utf8.decode(response.bodyBytes));
    userData = data["data_body"];
    notifyListeners();
  }
}
