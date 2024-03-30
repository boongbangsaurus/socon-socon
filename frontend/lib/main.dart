import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socon/firebase_options.dart';
import 'package:socon/routes/router.dart';
import 'package:socon/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socon/viewmodels/boss_verification_view_model.dart';
import 'firebase_options.dart';

import 'package:webview_flutter/webview_flutter.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // runApp을 호출하기 전 위젯 바인딩 초기화
  await Firebase.initializeApp(
    options : DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>BossVerificationViewModel() ),
    ], child: MaterialApp.router(
      routerConfig: router,
      // routerDelegate: router.routerDelegate,
      // routeInformationParser: router.routeInformationParser,
      debugShowCheckedModeBanner: false,
      title: 'Socon',
      theme: ThemeData(fontFamily: 'Pretendard',
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.white),
        primaryColor: AppColors.WHITE,
        // useMaterial3: true, // 이 줄을 주석 처리하거나 삭제하여 사용하시는 버전에 맞게 설정하세요.
      ),


    ),);
  }
}
