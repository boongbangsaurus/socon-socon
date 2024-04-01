import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:socon/models/business_owner.dart';
import 'package:socon/views/screens/bossVerification/boss_verification.dart';

import '../utils/api/api_utils.dart';
import '../utils/api/users/fetch_boss_data.dart';

class BossVerificationService {
  final String _serviceKey =
      "QHVWdJzNS9pOiKKpzybYKih%2FLMoY1qWyJpopp96jswnJeq8hht7C9pEpror35Jv4qnksDkqs27yQeYIOPa6aNg%3D%3D";

  // 사장님 인증
  Future<bool> verifyBoss(BusinessOwner businessOwner) async {
    print("사장님 인증 시작 $businessOwner");
    final result = await checkBusinessRegistration(businessOwner.registrationNumber);

    if (result == true) {
      print("시작하께오");
      await checkBossAgain(businessOwner);
    }

    return true;
  }

  // 사업자 등록증 인증
  Future<bool> checkBusinessRegistration(String registrationNumber) async {
    print("사업자 등록증 인증 시작");
    final response = await ApiUtils.postVerifyBoss('?serviceKey=$_serviceKey', {
      "b_no": [registrationNumber]
    });

    print("사업자 등록증 인증 결과값 $response");
    // return true;

    Map<String, dynamic> jsonResponseMap = jsonDecode(response);
    String statusCode = jsonResponseMap["status_code"];
    print("statueCode $statusCode");
    if (statusCode == "OK") {
      print('사업자 인증 성공 ${response}');
      return true;
    } else {
      print('사업자 인증 실패 ${response}');
      return false;
    }
  }

  // 사장님 인증
  Future<bool> checkBossAgain(BusinessOwner businessOwner) async {
    print("사장님 인증 2차 시작");
    final response = await ApiUtils.postDataWithToken(
        '/api/v1/stores/business', businessOwner);

    print("사업자 등록증 인증 결과값 $response");
    // return true;

    return true;
    // Map<String, dynamic> jsonResponseMap = jsonDecode(response);
    // String statusCode = jsonResponseMap["status_code"];
    // print("statueCode $statusCode");
    // if (response.successCode == "OK") {
    //   print('사업자 인증 성공 ${response}');
    //   return true;
    // } else {
    //   print('사업자 인증 실패 ${response}');
    //   return false;
    // }
  }
}
// final String serviceKey =
//     "QHVWdJzNS9pOiKKpzybYKih%2FLMoY1qWyJpopp96jswnJeq8hht7C9pEpror35Jv4qnksDkqs27yQeYIOPa6aNg%3D%3D";
// final baseUrl = "https://api.odcloud.kr/api/nts-businessman/v1/status";
// late final url;

// Future<bool> verifyBoss(String registrationNumber) async {
//   print("인증 시작 $registrationNumber");
//   await fetchBossData.check
// 1. 사업자 등록증 인증

// 2. 백엔드에서 2차 검증

//
//   Future<bool> checkBusinessRegistration(String registrationNumber) async {
//     print("인증 시작 $registrationNumber");
//     final response = await http.post(
//       Uri.parse(url),
//       headers: <String, String>{
//         'Accept': 'application/json',
//         "Authorization": "*/*",
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "b_no": [
//           registrationNumber
//         ]
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       print('사업자 인증 성공 ${response.body}');
//       return true;
//     } else {
//       print('사업자 인증 실패 ${response.body}');
//       return false;
//     }
//   }
// }
