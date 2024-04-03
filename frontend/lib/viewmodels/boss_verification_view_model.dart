import 'package:flutter/material.dart';
import 'package:socon/services/boss_verification_service.dart';

import '../models/business_owner.dart';

class BossVerificationViewModel extends ChangeNotifier {
  final BossVerificationService _bossVerificationService =
  BossVerificationService();
  late bool _isVerified;

  bool get isVerified => _isVerified;

  Future<void> verifyBoss(BusinessOwner businessOwner) async {
    _isVerified = await _bossVerificationService.verifyBoss(businessOwner);
    notifyListeners();
  }
}