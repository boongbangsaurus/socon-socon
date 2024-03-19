import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socon/widgets/socon_mysocon.dart';


class Sogon extends StatelessWidget {
  Sogon({super.key});

  // 데이터 배열
  final List<String> soconNames = ['소금빵', '마카롱', '상추', '콜라', '후라이드', '아메리카노'];
  final List<String> storeNames = ['오소유', '빵집1', '마트1', '마트2', '치킨집', '카페1'];
  final List<String> dueDate = ['2024-02-11', '2024-02-10', '2025-06-09', '2024-07-12', '2024-08-30', '2024-01-01'];
  final List<String> imageUrl = ['https://cdn.pixabay.com/photo/2017/12/10/13/37/christmas-3009949_1280.jpg','https://cdn.pixabay.com/photo/2017/12/10/13/37/christmas-3009949_1280.jpg','https://cdn.pixabay.com/photo/2017/12/10/13/37/christmas-3009949_1280.jpg','https://cdn.pixabay.com/photo/2017/12/10/13/37/christmas-3009949_1280.jpg','https://cdn.pixabay.com/photo/2017/12/10/13/37/christmas-3009949_1280.jpg','https://cdn.pixabay.com/photo/2017/12/10/13/37/christmas-3009949_1280.jpg',];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        shrinkWrap: true, // child 위젯의 크기를 정해주지 않은 경우 true로 지정해야됨
        itemCount: soconNames.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2, //1 개의 행에 보여줄 item 개수
          childAspectRatio: 1 / 1.2, //item 의 가로 세로의 비율
          mainAxisSpacing: 5, //수평 Padding
          crossAxisSpacing: 5, //수직 Padding
        ),
        itemBuilder: (BuildContext context, index) {
          return MySocon(
            soconName: soconNames[index],
            storeName: storeNames[index],
            dueDate: dueDate[index],
            imageUrl: imageUrl[index],
          );
        },
      ),
    );
  }
}
