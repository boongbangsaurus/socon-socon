import 'package:flutter/material.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/view/atoms/inputs.dart';
import 'package:socon/view/atoms/searchBox.dart';
import 'package:socon/view/modules/PlaceList.dart';
import './utils/toast_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socon',
      theme: ThemeData(fontFamily: 'Pretendard'
          // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),
          // primaryColor: AppColors.mainYellow
          // useMaterial3: true, // 이 줄을 주석 처리하거나 삭제하여 사용하시는 버전에 맞게 설정하세요.
          ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainScreen();
  }
}

class _MainScreen extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Toast"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SearchBox(),
            // ElevatedButton(
            //   child: const Text("Show Toast"),
            //   onPressed: () {
            //     ToastUtil.showCustomToast(context, "availableSocon");
            //   },
            // ),
            Expanded(
                child: SizedBox(
              width: ResponsiveUtils.getWidthWithPixels(context, 320),
              child: const PlaceList(),
            )),
            SizedBox(
              height: 80,
              width: 300,
              child: Inputs(
                labelText: '아이디',
                onSaved: (val) {},
                validator: (val) {
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
