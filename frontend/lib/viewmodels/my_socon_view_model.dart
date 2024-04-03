import 'package:flutter/cupertino.dart';
import 'package:socon/services/my_socon_service.dart';

class MySoconViewModel extends ChangeNotifier {
  final MySoconService _mySoconService = MySoconService();

  Future<Map<String, dynamic>?> getMySoconList() async {
    try {
      Map<String, dynamic> soconList = await _mySoconService.getMySoconList();
      print("[viewModel] 소콘북 소콘 목록 가져오기 성공 $soconList");
      return soconList;
    } catch (error) {
      print("[viewModel] 소콘북 소콘 목록 가져오기 실패 $error");
      return null; // 예외 발생 시 null 반환
    }
  }
}
