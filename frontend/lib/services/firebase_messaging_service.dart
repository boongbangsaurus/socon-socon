
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessaginService {

  Future<String?> getFcmToken() async {
    try{
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print("fcmToken $fcmToken");
      return fcmToken;
    }catch(error) {
      print("fcmToken 가져오기 실패 $error");
      return null;
    }
  }
}