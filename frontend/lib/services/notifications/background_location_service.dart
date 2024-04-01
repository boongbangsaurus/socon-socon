import 'package:background_locator_2/background_locator.dart';
import '../../utils/location_callback_handler.dart';

class BackgroundLocationService {
  static Future<void> startLocator() async {
    Map<String, dynamic> data = {'countInit': 1};
    await BackgroundLocator.registerLocationUpdate(
      LocationCallbackHandler.callback,
      initCallback: LocationCallbackHandler.initCallback,
      initDataCallback: data,
      disposeCallback: LocationCallbackHandler.disposeCallback,
      autoStop: false,
    );
  }
}
