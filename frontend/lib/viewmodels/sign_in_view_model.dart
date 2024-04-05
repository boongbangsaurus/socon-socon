import 'package:flutter/material.dart';
import 'package:socon/models/user.dart';
import 'package:socon/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socon/models/product_detail_model.dart';
import 'package:socon/viewmodels/sogon_view_model.dart';

/// [SignInViewModel]
/// view의 실제 로직 구현 (폼 검증, 서비스 호출)
class SignInViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final SogonViewModel sogonViewModel = SogonViewModel();
  // api 요청
  Future<bool> signIn(User user) async {
    List? token = await _authService.signIn(user);
    if (token?[0] != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.reload();
      await prefs.setString('accessToken', token?[0]);
      await prefs.setString('refreshToken', token?[1]);
      await prefs.setString('nickname', token?[2]);
      await sogonViewModel.getUid();
      return true;
    } else {
      return false;
    }
  }
}
