import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/inputs.dart';
import 'package:socon/views/atoms/tab.dart';
import 'package:socon/views/atoms/tag_icon.dart';
import 'package:socon/views/modules/store_register_view.dart';
import 'package:socon/views/atoms/image_loader.dart';

import '../../utils/fontSizes.dart';

class MyStoreListScreen extends StatefulWidget {
  const MyStoreListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyStoreListScreen();
  }
}

class _MyStoreListScreen extends State<MyStoreListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('소콘소콘'),
        actions: [],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: TabBarScreen(contents: {
                  '내 점포': MyStoreLists(),
                  '점포 분석': MyStoreAnalysis(),
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





class MyStoreLists extends StatefulWidget {
  const MyStoreLists({super.key});

  @override
  State<MyStoreLists> createState() => _MyStoreListsState();
}

class _MyStoreListsState extends State<MyStoreLists> {
  String _userInput = '';



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                height: 80,
                width: 80,
                child: ImageLoader(
                  imageUrl: "https://cataas.com/cat",
                  borderRadius: 15.0,
                ),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              flex: 2,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('오소유', style: TextStyle(fontSize: FontSizes.LARGE, fontWeight: FontWeight.bold),),
                      TagIcon(buttonText: '빵집', buttonColor: Colors.amber, buttonTextColor: Colors.white,)
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios),
          ],
                ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          width: double.infinity, // 화면 너비에 맞춤
          height: 48.0, // 적당한 높이
          decoration: BoxDecoration(
            // 그림자 추가
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 2), // 그림자의 위치 조정
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Color(0xFFF8D461); // 클릭 시 배경색
                  }
                  return Colors.white; // 기본 배경색
                },
              ),
              foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.black; // 클릭 시 글자색
                  }
                  return Colors.black; // 기본 글자색
                },
              ),

              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide(color: Colors.grey),
                ),
              ),
              elevation: MaterialStateProperty.resolveWith<double>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return 0; // 클릭 시 그림자 제거
                  }
                  return 4; // 기본 그림자
                },
              ),
            ),
            child: Text('점포 등록하기'),
          ),
        ),

      ],
    );
  }
}



class MyStoreAnalysis extends StatelessWidget {
  const MyStoreAnalysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('text'),
      ],
    );
  }
}
