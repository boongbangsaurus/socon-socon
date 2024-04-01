import 'package:flutter/cupertino.dart';
import 'package:socon/services/notifications/firebase_messaging_service.dart';
import 'package:socon/services/image_manager_service.dart';

class SoconCouponViewModel extends ChangeNotifier {
  final ImageManagerService _imageManagerService = ImageManagerService();
  bool _isSaving = false;

  bool get isSaving => _isSaving;

  Future<void> captureAndSaveImage(GlobalKey globalKey) async {
    try {
      _isSaving = await _imageManagerService.captureAndSaveImage(globalKey);
      notifyListeners();
      print("캡처 and 사진 저장 성공");
    } catch (error) {
      print("캡처 and 사진 저장 실패 $error");
    }
  }
}
