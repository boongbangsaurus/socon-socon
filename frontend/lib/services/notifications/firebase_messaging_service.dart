import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class FirebaseMessagingService {


  // fcmToken 가져오는 메소드
  Future<String?> getFcmToken() async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print("fcmToken이에요 $fcmToken");
      return fcmToken;
    } catch (error) {
      print("fcmToken 가져오기 실패 $error");
      return null;
    }
  }
}
