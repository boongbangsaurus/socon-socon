import 'package:flutter/material.dart';
import 'package:socon/services/boss_verification_service.dart';

class BossVerificationViewModel extends ChangeNotifier {
  final BossVerificationService _bossVerificationService =
  BossVerificationService();
  late bool _isVerified;

  bool get isVerified => _isVerified;

  Future<void> verifyBoss(String registrationNumber) async {
    _isVerified = await _bossVerificationService.verifyBoss(registrationNumber);
    notifyListeners();
  }
}