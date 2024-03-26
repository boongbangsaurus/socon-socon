import 'package:flutter/material.dart';
import 'package:socon/models/user.dart';
import 'package:socon/services/auth_service.dart';

/// [SignUpViewModel]
/// view의 실제 로직 구현 (폼 검증, 서비스 호출)
class SignUpViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Future<bool> signUp(User user) async {
    return await _authService.signUp(user);
  }
}
