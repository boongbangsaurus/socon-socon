import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:socon/models/comment.dart';
import 'package:socon/models/socon_book.dart';
import 'package:socon/models/sogon_detail.dart';
import 'package:socon/models/sogon_register.dart';
import 'package:socon/services/sogon_service.dart';

import '../models/locations.dart';
// import 'package:shared_preferences/shared_preferences.dart';

/// [SogonViewModel]
/// view의 실제 로직 구현 (폼 검증, 서비스 호출)
class SogonViewModel extends ChangeNotifier {
  final SogonService _sogonService = SogonService();
  SogonDetail? sogonDetail;
  List<SogonComment>? comments;

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
  Future<Map<String, dynamic>> getSogonDetail(String sogon_id) async {
    Map<String, dynamic>? sogons = await _sogonService.getSogonDetail(sogon_id);
    if (sogons != null &&
        sogons.containsKey('sogon') &&
        sogons.containsKey('comments')) {
      var sogonData = sogons['sogon'];
      sogonDetail = SogonDetail(
          id: (sogonData['id'] as num).toInt(),
          title: sogonData['title'],
          member_name: sogonData['member_name'],
          member_img: sogonData['member_img'],
          content: sogonData['content'],
          image1: sogonData['image1'],
          image2: sogonData['image2'],
          socon_img: sogonData['socon_img'],
          create_at: DateFormat("yyyy-MM-dd'T'HH:mm:ss")
              .parse(sogonData['created_at']),
          expired_at: DateFormat("yyyy-MM-dd'T'HH:mm:ss")
              .parse(sogonData['expired_at']),
          expired: sogonData['expired']);

      var commentsData = List.from(sogons['comments']);
      comments = commentsData
          .map((commentData) => SogonComment.fromJson(commentData))
          .toList();

      notifyListeners(); // 상태가 변경되었음을 알림
    }
    return sogons ?? {};
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

  // 소곤 등록 POST API
  Future<bool> sogonRegister(SogonRegister sogonRegister) async {
    bool res = await _sogonService.sogonRegister(sogonRegister);
    print('====================== sogonRegister');
    print(res);
    return res;
  }

  // 소곤 댓글 POST API
  Future<bool> commentRegister(String sogon_id, String comment) async {
    bool res = await _sogonService.commentRegister(sogon_id, comment);
    getSogonDetail(sogon_id);
    return res;
  }

  // 소곤 채택 API
  Future<bool> setPicked(String sogon_id, String comment_id) async {
    bool res = await _sogonService.setPicked(sogon_id, comment_id);
    getSogonDetail(sogon_id);
    return res;
  }

  // Firebase Authentication GET uid
  Future<String> getUid() async {
    String res = await _sogonService.getUid();
    await signInWithCustomToken(res);

    return res;
  }

  // Firebase Authentication 인증
  Future<void> signInWithCustomToken(String customToken) async {
    try {
      // 사용자 정의 토큰으로 Firebase에 인증 요청
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCustomToken(customToken);

      // 인증 성공 후 작업, 예를 들어 홈 페이지로 이동
      print("인증 성공: ${userCredential.user?.uid}");
    } on FirebaseAuthException catch (e) {
      print("Firebase 인증 에러: $e");
    } catch (e) {
      print("인증 에러: $e");
    }
  }
}
