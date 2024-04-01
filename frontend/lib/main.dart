import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:socon/firebase_options.dart';
import 'package:socon/routes/router.dart';
import 'package:socon/services/notifications/background_location_service.dart';
import 'package:socon/services/notifications/background_message_handler.dart';
import 'package:socon/services/permission_handler.dart';
import 'package:socon/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socon/utils/firebase_utils.dart';
import 'package:socon/utils/location_callback_handler.dart';
import 'package:socon/utils/location_service_repository.dart';
import 'package:socon/viewmodels/login_state_view_model.dart';
import 'package:socon/viewmodels/boss_verification_view_model.dart';
import 'package:socon/viewmodels/notification_view_model.dart';

import 'models/location.dart';

LocationDto locationDto = LocationDto(
  37.7749,
  // latitude
  -122.4194,
  // longitude
  10.0,
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // runApp을 호출하기 전 위젯 바인딩 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (!kIsWeb) {
    await FirebaseUtils().setupFlutterNotifications();
  }

  NotificationViewModel _notificationViewModel = NotificationViewModel();

  var fcmToken = await _notificationViewModel.getFcmToken();
  print("fcmToken야. $fcmToken");
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  await getPermissionHandler();

  // 백그라운드 메세지 설정
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ReceivePort port = ReceivePort();

  String logStr = '';
  late bool isRunning;
  late LocationDto lastLocation;

  @override
  void initState() {
    super.initState();

    if (IsolateNameServer.lookupPortByName(
            LocationServiceRepository.isolateName) !=
        null) {
      IsolateNameServer.removePortNameMapping(
          LocationServiceRepository.isolateName);
    }

    IsolateNameServer.registerPortWithName(
        port.sendPort, LocationServiceRepository.isolateName);

    port.listen(
      (dynamic data) async {
        await updateUI(data);
      },
    );
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> updateUI(dynamic data) async {
    // final log = await FileManager.readLogFile();

    LocationDto? locationDto =
        (data != null) ? LocationDto.fromJson(data) : null;
    await _updateNotificationText(locationDto!);

    setState(() {
      if (data != null) {
        lastLocation = locationDto;
      }
      logStr = log as String;
      print("log를 찍어볼게 $logStr");
    });
  }

  Future<void> _updateNotificationText(LocationDto data) async {
    if (data == null) {
      print("null이야.");
      return;
    }

    await BackgroundLocator.updateNotificationText(
        title: "new location received",
        msg: "${DateTime.now()}",
        bigMsg: "${data.latitude}, ${data.longitude}");
  }

  Future<void> initPlatformState() async {
    print('Initializing...');
    await BackgroundLocator.initialize();
    // logStr = await FileManager.readLogFile();
    print('Initialization done');
    final _isRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = _isRunning;
    });
    print('Running ${isRunning.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    final start = SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        child: Text('Start'),
        onPressed: () {
          _onStart();
        },
      ),
    );
    final stop = SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        child: Text('Stop'),
        onPressed: () {
          onStop();
        },
      ),
    );
    final clear = SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        child: Text('Clear Log'),
        onPressed: () {
          // FileManager.clearLogFile();
          setState(() {
            logStr = '';
          });
        },
      ),
    );
    String msgStatus = "-";
    if (isRunning != null) {
      if (isRunning) {
        msgStatus = 'Is running';
      } else {
        msgStatus = 'Is not running';
      }
    }
    final status = Text("Status: $msgStatus");

    final log = Text(
      logStr,
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter background Locator'),
        ),
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[start, stop, clear, status, log],
            ),
          ),
        ),
      ),
    );
  }

  void onStop() async {
    await BackgroundLocator.unRegisterLocationUpdate();
    final _isRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = _isRunning;
    });
  }

  void _onStart() async {
    print("시작!");
    await _startLocator();
    final _isRunning = await BackgroundLocator.isServiceRunning();

    setState(() {
      isRunning = _isRunning;
      lastLocation = locationDto;
    });
  }

  Future<void> _startLocator() async {
    Map<String, dynamic> data = {'countInit': 1};
    return await BackgroundLocator.registerLocationUpdate(
        LocationCallbackHandler.callback,
        initCallback: LocationCallbackHandler.initCallback,
        initDataCallback: data,
        disposeCallback: LocationCallbackHandler.disposeCallback,
        autoStop: false,
        androidSettings: const AndroidSettings(
            interval: 5,
            distanceFilter: 0,
            client: LocationClient.google,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'Start Location Tracking',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                    'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
                notificationIconColor: Colors.grey,
                notificationTapCallback:
                    LocationCallbackHandler.notificationCallback)));
  }
}

// class _MyAppState extends State<MyApp> {
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => BossVerificationViewModel()),
//         ChangeNotifierProvider(create: (context) => LoginState()),
//       ],
//       child: MaterialApp.router(
//         routerConfig: router,
//         debugShowCheckedModeBanner: false,
//         title: 'Socon',
//         theme: ThemeData(
//           fontFamily: 'Pretendard',
//           primaryColor: AppColors.WHITE,
//           // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.white),
//           // useMaterial3: true,
//         ),
//       ),
//     );
//   }
// }
