import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StoreLists extends StatelessWidget {
  const StoreLists({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('소콘소콘', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.crop_free),
            iconSize: 30,
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.favorite_rounded, color: Colors.red, ),
            iconSize: 30,
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.notifications_none_rounded),
            iconSize: 30,
          ),
        ],

      ),

      body: Text('메인 가게리스트 페이지 입니다'),
    );
  }
}
