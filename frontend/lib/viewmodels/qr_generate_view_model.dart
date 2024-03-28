import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:socon/services/qr_publishing_service.dart';

class QrGenerateViewModel {
  final QrPublishingService _qrPublishingService = QrPublishingService();

  Future<String?> makeQrCode() async {
    var fcmToken = await _qrPublishingService.makeQrCode();
  }
}
