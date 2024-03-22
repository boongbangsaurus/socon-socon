import 'package:flutter/material.dart';
import 'package:socon/view/modules/store_register_view.dart';

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
      body: Column(
        children: [
          Text('내점포 / 점포분석'),
          Text('내 점포 리스트'),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterPage()),
              );
            },
            child: Text('점포 등록하기'),
          )
        ],
      ),
    );
  }
}
