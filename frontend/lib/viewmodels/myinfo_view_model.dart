import 'package:flutter/material.dart';
import 'package:socon/services/auth_service.dart';


class MyInfoViewModel extends ChangeNotifier {

  final AuthService _authService = AuthService();

  Future<void> getUserInfo() async {
    await _authService.getUserInfo();
    notifyListeners();
  }
}

