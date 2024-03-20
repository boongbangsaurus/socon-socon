import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'pages/main_store_lists.dart';
import 'pages/sogon.dart';
import 'pages/mystore.dart';
import 'pages/coupon_lists.dart';
import 'pages/mypage.dart';

import 'store_register/register_page.dart';


void main() {
  runApp(MaterialApp(
      // 테스트시 디버그 라벨 없에기
      debugShowCheckedModeBanner: false,

      // CSS 스타일 같은것
      // theme: style.theme,
      home: MyApp())
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab_idx = 0;
  var is_owner = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: [RegisterPage(), Sogon(), if(is_owner) MyStore(), CouponLists(), MyPage(),][tab_idx],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // selectedItemColor: Colors.red,
        // unselectedItemColor: Colors.grey,
        onTap: (i){
          setState(() {
            tab_idx = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.place_outlined, color: Colors.black87, size: 30), label: '주변정보'),
          BottomNavigationBarItem(icon: Icon(Icons.sms_outlined, color: Colors.black87, size: 30), label: '소곤'),
          if(is_owner) BottomNavigationBarItem(icon: Icon(Icons.storefront, color: Colors.black87, size: 30), label: ' '),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_num_outlined, color: Colors.black87, size: 30), label: '쿠폰북'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded, color: Colors.black87, size: 30), label: '내정보'),
          ],
        ),
      );
    }
  }



