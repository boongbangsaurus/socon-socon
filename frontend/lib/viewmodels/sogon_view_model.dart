import 'package:socon/models/socon_book.dart';
import 'package:socon/models/sogon_register.dart';
import 'package:socon/services/sogon_service.dart';

import '../models/locations.dart';
// import 'package:shared_preferences/shared_preferences.dart';

/// [SogonViewModel]
/// view의 실제 로직 구현 (폼 검증, 서비스 호출)
class SogonViewModel {
  final SogonService _sogonService = SogonService();

  // 소곤 리스트 api 요청
  Future<List?> sogonList(Locations location) async {
    List? sogons = await _sogonService.getMarker(location);
    if (sogons?.length != 0) {
      return sogons;
    } else {
      return null;
    }
  }

  // 소곤 상세 조회 GET api 요청
  Future<Map<String, dynamic>> sogonDetail(int id) async {
    Map<String, dynamic>? sogons = await _sogonService.getSogonDetail(id);
    if (sogons != null) {
      return sogons;
    } else {
      return {};
    }
  }

  // 보유 소콘
  Future<List<dynamic>> socons() async {
    List<dynamic> res = await _sogonService.getSocons();
    List<SoconBook> socons = [];

    for (var item in res) {
      SoconBook soconBook = SoconBook.fromJson(item);
      if (soconBook.status == "unused") {
        socons.add(soconBook);
      }
    }
    print("=============== my soconBook list ===============");
    print(socons.toString());
    print("=============== my soconBook list ===============");

    if (socons != null) {
      return socons;
    } else {
      return [];
    }
  }

  Future<bool> sogonRegister(SogonRegister sogonRegister) async {
    bool res = await _sogonService.sogonRegister(sogonRegister);

    if (res != null) {
      return false;
    } else {
      return true;
    }
  }
}
