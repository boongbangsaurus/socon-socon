import 'package:flutter/material.dart';

import '../../utils/fontSizes.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyInfoScreen();
  }
}

class _MyInfoScreen extends State<MyInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "내 정보",
          style: TextStyle(fontSize: FontSizes.LARGE),
        ),
      ),
    );
  }
}
