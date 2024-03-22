import 'package:flutter/material.dart';

import '../../utils/fontSizes.dart';

class SoconBookScreen extends StatefulWidget {
  const SoconBookScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SoconBookScreen();
  }
}

class _SoconBookScreen extends State<SoconBookScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "소콘북",
          style: TextStyle(fontSize: FontSizes.LARGE),
        ),
      ),
    );
  }
}
