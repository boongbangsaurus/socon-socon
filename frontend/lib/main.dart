
import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:socon/viewmodels/menu.dart';

import 'dart:async';

import 'package:uni_links/uni_links.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:socon/firebase_options.dart';
import 'package:socon/provider/Boss_provider.dart';
import 'package:socon/routes/router.dart';
import 'package:socon/services/notifications/background_location_service.dart';
import 'package:socon/services/notifications/background_message_handler.dart';
import 'package:socon/services/permission_handler.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/firebase_utils.dart';
import 'package:socon/utils/location/location_callback_handler.dart';
import 'package:socon/utils/location/location_service_repository.dart';
import 'package:socon/viewmodels/boss_verification_view_model.dart';

import 'package:socon/viewmodels/login_state_view_model.dart';

import 'package:socon/viewmodels/payment_verification_view_model.dart';
import 'package:socon/viewmodels/store_register_view_model.dart';

import 'package:socon/viewmodels/notification_view_model.dart';
import 'package:socon/views/screens/bossVerification/boss_verification.dart';

import 'provider/Address.dart';
import 'models/location.dart';


import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // runApp을 호출하기 전 위젯 바인딩 초기화

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb) {
    await FirebaseUtils().setupFlutterNotifications();
  }

  // FCM 토큰 가져오기
  NotificationViewModel _notificationViewModel = NotificationViewModel();
  var fcmToken = await _notificationViewModel.getFcmToken();
  print("fcmToken: $fcmToken");
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  // 위치 권한 요청
  await getPermissionHandler();

  uriLinkStream.listen((Uri? uri) {
    print("딥링크 구현 $uri");
    router.go("/info");
  }, onError: (Object error) {
    print("딥링크 이동 $error");
  }, onDone: (){
    print("딥링크 이동 완료");
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // foreground에서 fcm 메세지 처리
    print(
        "[포어그라운드] FCM 메세지를 받았는데요. 저는 집에 가고 싶네요. ${message.notification!.body}");
    FirebaseUtils().showFlutterNotification(message);
  });

  // 백그라운드 메시지 핸들러 설정
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


  // google map 설정
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
    initializeMapRenderer();
  }

  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ReceivePort port;
  late bool isRunning = false;
  late LocationDto lastLocation;
  String logStr = '';

  @override
  void initState() {
    super.initState();
    port = ReceivePort();

    // 백그라운드 isolate에서의 메시지 수신을 위한 포트 설정
    IsolateNameServer.registerPortWithName(
        port.sendPort, LocationServiceRepository.isolateName);

    port.listen((dynamic data) async {
      print("데이터 값!!! $data");
      updateUI(data);
    });

    initPlatformState();

    // _onStart();  // 잠시 주석 처리
  }

  @override
  void dispose() {
    super.dispose();
    // 포트 제거
    IsolateNameServer.removePortNameMapping(
        LocationServiceRepository.isolateName);
  }

  Future<void> initPlatformState() async {
    print('초기화 시작');
    await BackgroundLocator.initialize();

    // 백그라운드 서비스 실행 여부 확인
    isRunning = await BackgroundLocator.isServiceRunning();
    print('isRunning 상태 ${isRunning.toString()}');
    print('초기화 끝');
  }

  Future<void> _updateNotificationText(LocationDto data) async {
    if (data == null) {
      return;
    }

    await BackgroundLocator.updateNotificationText(
      title: "new location received",
      msg: "${DateTime.now()}",
      bigMsg: "${data.latitude}, ${data.longitude}",
    );
  }

  Future<void> updateUI(dynamic data) async {
    LocationDto? locationDto =
        (data != null) ? LocationDto.fromJson(data) : null;
    if (locationDto != null) {
      await _updateNotificationText(locationDto);

      setState(() {
        lastLocation = locationDto;
        logStr =
            'Latitude: ${locationDto.latitude}, Longitude: ${locationDto.longitude}';
      });
    }
  }

  void onStop() async {
    // 백그라운드 위치 업데이트 중지
    await BackgroundLocator.unRegisterLocationUpdate();
    isRunning = await BackgroundLocator.isServiceRunning();
    setState(() {});
  }

  void _onStart() async {
    print("시작!");
    await BackgroundLocationService.startLocator();
    isRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      // 위치 업데이트 시작 시 lastLocation 초기화
      lastLocation = LocationDto(
        0.0,
        // latitude
        0.0,
        // longitude
        0.0,
        // accuracy
        0.0,
        // altitude
        0.0,
        // speed
        0.0,
        // speedAccuracy
        0.0,
        // heading
        DateTime.now().millisecondsSinceEpoch.toDouble(),
        // time
        false,
        // isMocked
        'gps', // provider
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BossVerificationViewModel()),
        ChangeNotifierProvider(create: (context) => LoginState()),
        ChangeNotifierProvider(create: (context) => PaymentVerificationViewModel()),
        ChangeNotifierProvider(create: (context) => StoreRegisterViewModel()),
        ChangeNotifierProvider(create: (_) => BossProvider()),
        // ChangeNotifierProvider(create: (context) => MystoreListsViewModel(),),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Socon',
        theme: ThemeData(
          fontFamily: 'Pretendard',
          primaryColor: AppColors.WHITE,
          // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.white),
          // useMaterial3: true,
        ),
      ),
    );
  }
}

// 위치 정보 widget
// final log = Text(logStr);

Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

/// Initializes map renderer to the `latest` renderer type for Android platform.
///
/// The renderer must be requested before creating GoogleMap instances,
/// as the renderer can be initialized only once per application context.
Future<AndroidMapRenderer?> initializeMapRenderer() async {
  if (_initializedRendererCompleter != null) {
    return _initializedRendererCompleter!.future;
  }

  final Completer<AndroidMapRenderer?> completer =
      Completer<AndroidMapRenderer?>();
  _initializedRendererCompleter = completer;

  WidgetsFlutterBinding.ensureInitialized();

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    unawaited(mapsImplementation
        .initializeWithRenderer(AndroidMapRenderer.latest)
        .then((AndroidMapRenderer initializedRenderer) =>
            completer.complete(initializedRenderer)));
  } else {
    completer.complete(null);
  }

  return completer.future;
}
