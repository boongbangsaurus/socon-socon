import 'package:flutter/material.dart';

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
    return const Scaffold(
      body: Center(
        child: Text(
          "점포 목록",
          style: TextStyle(fontSize: FontSizes.LARGE),
        ),
      ),
    );
  }
}
