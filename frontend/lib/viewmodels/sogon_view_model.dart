import 'package:flutter/material.dart';
import 'package:socon/models/location.dart';
import 'package:socon/services/sogon_service.dart';
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

  // 소곤 상세 조회 api 요청
  Future<Map<String, dynamic>> sogonDetail(int id) async {
    Map<String, dynamic>? sogons = await _sogonService.getSogonDetail(id);
    if (sogons != null) {
      return sogons;
    } else {
      return {};
    }
  }
}
