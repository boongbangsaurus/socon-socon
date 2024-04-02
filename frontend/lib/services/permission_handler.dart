import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart';

@pragma('vm:entry-point')
Future<void> getPermissionHandler() async {
  await getNotificationPermission();
  await getLocationPermission();
}

Future<void> getLocationPermission() async {
  var status = await Permission.locationAlways.status; // 위치 권한 항상 허용
  print("위치 정보 요청 $status");
  if (status.isGranted) {
    // 권한이 이미 부여됨
    await checkAndEnableLocationService();
  } else if (status.isDenied) {
    // 권한 요청
    status = await Permission.location.request();
    print("거부 후  $status");

    if (status.isGranted) {
      // 권한이 부여된 후 위치 서비스 확인
      await checkAndEnableLocationService();
    } else {
      // 권한 거부 처리
      print("권한 처리되어야 위치 알림 사용가능");
    }
  } else if (status.isPermanentlyDenied || status.isRestricted) {
    // 권한 거부/제한 처리
    print("위치 권한이 거부 혹은 제한. 앱 설정으로 이동합니다.");
    openAppSettings();
  }
}

Future<void> checkAndEnableLocationService() async {
  var locationService = Location();
  bool serviceEnabled = await locationService.serviceEnabled();
  if (!serviceEnabled) {
    // 위치 서비스 활성화 요청
    serviceEnabled = await locationService.requestService();
    if (!serviceEnabled) {
      // 위치 서비스 활성화 거부 처리
      print("위치 서비스를 활성화해야 위치 정보를 사용할 수 있습니다.");
      return;
    }
  }
  // 위치 정보 처리 로직
  print("위치 정보를 얻어올 수 있습니다.");
}

Future<void> getNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    print("알림이 거부되어있습니다. 다시 권한을 요청합니다");
    await Permission.notification.request();
  } else {
    print("알림이 허용되어있습니다.");
  }
}
