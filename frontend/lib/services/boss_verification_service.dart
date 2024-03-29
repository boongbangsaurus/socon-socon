import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:socon/models/business_owner.dart';
import 'package:socon/views/screens/bossVerification/boss_verification.dart';

class BossVerificationService {
  final String serviceKey =
      "QHVWdJzNS9pOiKKpzybYKih%2FLMoY1qWyJpopp96jswnJeq8hht7C9pEpror35Jv4qnksDkqs27yQeYIOPa6aNg%3D%3D";
  final baseUrl = "https://api.odcloud.kr/api/nts-businessman/v1/status";
  late final url;

  BossVerificationService() {
    url = "$baseUrl?serviceKey=$serviceKey";
  }

  Future<bool> verifyBoss(String registrationNumber) async {
    print("인증 시작 $registrationNumber");
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Accept': 'application/json',
        "Authorization": "*/*",
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "b_no": [
          registrationNumber
        ]
      }),
    );

    if (response.statusCode == 200) {
      print('사업자 인증 성공 ${response.body}');
      return true;
    } else {
      print('사업자 인증 실패 ${response.body}');
      return false;
    }
  }
}
