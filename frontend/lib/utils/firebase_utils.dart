// lib/utils/firebase_utils.dart

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseUtils {
  bool isFlutterLocalNotificationsInitialized = false; // 푸시 알림 초기화 여부
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel channel;

  // 환경 설정 메소드
  Future<void> setupFlutterNotifications() async {
    // 이미 초기화 -> 함수 종료
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    // android에서 사용할 알림 채널 설정
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      // id는 AndroidManifest.xml 파일에서 설정한 default_notification_channel_id 값과 같아야한다
      'high_importance_channel', // 채널 이름
      description:
      '[socon] This channel is used for important notifications.', // 채널 설명
      importance: Importance.high, // 알림 중요도 설정
    );


    // FlutterLocalNotificationsPlugin 인스턴스 생성
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Android에서 특정 플랫폼 구현을 가져와서 알림 채널 생성
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // 푸시 알림 초기화 끝
    isFlutterLocalNotificationsInitialized = true;
    print("세팅완");
    // String token =
    // "cON4QOYNSOmdaQ9Obtr8TQ:APA91bGTXdF5BsO8ZB_78i6IqJl6Xb8DKYtIPAtvwOzztibY-DN7r4vW0RhU8bOxsdwDTQvOWGgjeqbfHC-cq8x6KjtNzWbckMRs7tx-k2WhRdXSVa1IgpEWWGFeImSSWbuVTrbmSVhS";
    // if (token != null) {
    //   final String baseUrl = 'http://j10c207.p.ssafy.io:8000';
    //   String url = "$baseUrl/api/v1/notification/fcm/save";
    //   print("url $url");
    //
    //   final response = await http.post(
    //     Uri.parse(url),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json',
    //     },
    //     body:
    //     jsonEncode({"memberId": 1, "token": token, "deviceType": "MOBILE"}),
    //   );
    //
    //   print("토큰 저장 ${jsonDecode(response.body)}");
    // } else {
    //   print("토큰이 없어요");
    // }
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: 'launch_background',
          ),
        ),
      );
    }
  }
}
