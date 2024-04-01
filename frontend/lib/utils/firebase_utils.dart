import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseUtils {
  bool _isFlutterLocalNotificationsInitialized = false;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel? channel; // late 키워드 제거

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }

    // 알림 권한 요청
    if (await Permission.notification.isDenied) {
      print("알림이 거부되어있습니다. 다시 권한을 요청합니다");
      await Permission.notification.request();
    }else{
      print("알림이 허용되어있습니다.");
    }

    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'high_importance_channel',
      description: '[socon] This channel is used for important notifications.',
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    _isFlutterLocalNotificationsInitialized = true;
    print("Notifications setup complete");
  }

  Future<void> showFlutterNotification(RemoteMessage message) async {
    if (!_isFlutterLocalNotificationsInitialized || channel == null) {
      await setupFlutterNotifications(); // 채널이 초기화되지 않았다면 초기화
    }

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel!.id,
            channel!.name,
            channelDescription: channel!.description,
            icon: 'launch_background',
          ),
        ),
      );
    }
  }
}
