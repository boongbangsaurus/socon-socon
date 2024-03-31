import 'package:flutter/material.dart';
import 'package:socon/models/location.dart';
import 'package:socon/services/sogon_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

/// [SogonListViewModel]
/// view의 실제 로직 구현 (폼 검증, 서비스 호출)
class SogonListViewModel {
  final SogonService _sogonService = SogonService();

  // api 요청
  Future<List?> sogonList(Locations location) async {
    List? sogons = await _sogonService.getMarker(location);
    if (sogons?.length != 0) {
      return sogons;
    } else {
      return null;
    }
  }
}
