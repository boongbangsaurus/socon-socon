
import 'package:socon/services/firebase_messaging_service.dart';

class NotificationViewModel {
  final FirebaseMessagingService _firebaseMessagingService = FirebaseMessagingService();

  // Future<void> setupNotifications() async{
  //    await _firebaseMessagingService.setupFlutterNotifications();
  //    print("firebase fcm 설정 완");
  // }

  Future<String?> getFcmToken() async{
    var fcmToken = await _firebaseMessagingService.getFcmToken();

    if(fcmToken != null){
      return fcmToken;
    }

    return null;
  }
}