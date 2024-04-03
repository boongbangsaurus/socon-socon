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
    final result =
        await checkBusinessRegistration(businessOwner.registrationNumber);

    if (result == true) {
      print("시작하께오");

      var formattedBusinessOwner = {
        "number": businessOwner.registrationNumber,
        "address": businessOwner.registrationAddress,
      };
      await checkBossAgain(formattedBusinessOwner);
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

  Future<bool> checkBossAgain(Map<String, String> businessOwner) async {
    print("사장님 인증 2차 시작 $businessOwner");
    try {
      final response = await ApiUtils.postDataWithToken(
          '/api/v1/stores/business', businessOwner);

      // 파싱된 JSON 응답을 가지고 처리할 코드
      // 예를 들어, 응답이 성공했는지 여부를 확인하고 그에 따라 true 또는 false를 반환

      final Map<String, dynamic> responseData = jsonDecode(response);
      final int successCode = responseData['data_header']['success_code'];

      if (successCode == 0) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('사장님 인증 실패: $error');
      return false;
    }
  }
}
