
import 'package:socon/services/firebase_messaging_service.dart';

class NotificationViewModel {
  final FirebaseMessaginService _firebaseMessagingService = FirebaseMessaginService();

  Future<bool> getFcmToken() async{
    var fcmToken = await _firebaseMessagingService.getFcmToken();

    if(fcmToken != null){
      return true;
    }

    return false;
  }
}