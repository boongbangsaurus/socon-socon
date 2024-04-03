import 'package:flutter/cupertino.dart';
import 'package:socon/services/my_socon_service.dart';

class MySoconViewModel extends ChangeNotifier {
  final MySoconService _mySoconService = MySoconService();
  List<dynamic>? usableList;
  List<dynamic>? usedMysoconList;

  Future<Map<String, dynamic>?> getMySoconList() async {
    try {
      Map<String, dynamic> soconList = await _mySoconService.getMySoconList();
      print("[viewModel] 소콘북 소콘 목록 가져오기 성공 $soconList");
      usableList = soconList['usable'];
      usedMysoconList = soconList['unusable'];
      print("사용가능 $usableList");
      notifyListeners();
      return soconList;
    } catch (error) {
      print("[viewModel] 소콘북 소콘 목록 가져오기 실패 $error");
      return null; // 예외 발생 시 null 반환
    }
  }

  Future<Map<String, dynamic>?> getSoconInfo(String soconId) async {
    try {
      Map<String, dynamic> soconInfo =
          await _mySoconService.getSoconInfo(soconId);
      print("[viewModel] 소콘 상세 정보 가져오기 성공 $soconInfo");
      // notifyListeners();
      return soconInfo;
    } catch (error) {
      print("[viewModel] 소콘 상세 정보 가져오기 실패 $error");
      return null; // 예외 발생 시 null 반환
    }
  }
}
