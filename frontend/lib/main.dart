import 'package:flutter/material.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/view/atoms/bottom_sheet.dart';
import 'package:socon/view/atoms/searchBox.dart';
import 'package:socon/view/modules/PlaceList.dart';
import './utils/toast_utils.dart';
import 'package:socon/view/atoms/buttons.dart';

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
      home: BottomSheet(),
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
            SizedBox(height: ResponsiveUtils.getWidthWithPixels(context, 10.0)),
            Expanded(
                child: SizedBox(
              width: ResponsiveUtils.getWidthWithPixels(context, 320),
              child: const PlaceList(),
            )),
          ],
        ),
      ),
    );
  }
}

class BottomSheet extends StatelessWidget {
  BottomSheet({super.key});

  final Widget _header = Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6.0, bottom: 8.0),
            width: 50.0,
            height: 6.5,
            decoration: BoxDecoration(
                color: Colors.black45, borderRadius: BorderRadius.circular(50)),
          ),
          // bottom header Title Text - nullable
          Text("Drag the header to see bottom sheet"),
        ],
      ));

  // Widget _buttonItem(BasicButton button) => Container(
  //       alignment: Alignment.center,
  //       child: button,
  //     );

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: _size.height,
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: CustomBottomSheet(
              // maxHeight: _size.height * 0.745,
              maxHeight: _size.height * 0.245,
              headerHeight: 50.0,
              header: this._header,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    spreadRadius: -1.0,
                    offset: Offset(0.0, 3.0)),
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    spreadRadius: -1.0,
                    offset: Offset(0.0, 0.0)),
              ],
              // body: Container(
              //   decoration: const BoxDecoration(
              //     border: Border(top: BorderSide(color: Colors.grey, width: 1.0)),
              //   ),
              //   width: _size.width,
              //   alignment: Alignment.center,
              //   height: _size.height * 0.6,
              //   child: Text("body")
              // ),
              children: [
                BasicButton(
                  onPressed: () {},
                  text: 'hi',
                ),
                BasicButton(
                  onPressed: () {},
                  text: 'hi',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
