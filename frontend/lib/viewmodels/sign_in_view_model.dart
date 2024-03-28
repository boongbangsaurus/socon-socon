import 'package:flutter/material.dart';
import 'package:socon/models/user.dart';
import 'package:socon/services/auth_service.dart';

/// [SignInViewModel]
/// view의 실제 로직 구현 (폼 검증, 서비스 호출)
class SignInViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  // api 요청
  Future<bool> signIn(User user) async {
    return await _authService.signIn(user);
  }
  // token 설정
}
