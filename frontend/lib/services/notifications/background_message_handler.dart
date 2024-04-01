import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../firebase_options.dart';
import '../../utils/firebase_utils.dart';

@pragma('vm:entry-point')

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseUtils().setupFlutterNotifications();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // foreground에서 fcm 메세지 처리
    print("[백그라운드] FCM 메세지를 받았는데요. 저는 집에 가고 싶네요. ${message.notification!.body}");
    FirebaseUtils().showFlutterNotification(message);
  });

  print('Handling a background message ${message.messageId}');
}
