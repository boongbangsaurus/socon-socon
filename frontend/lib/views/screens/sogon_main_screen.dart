import 'package:flutter/material.dart';
import 'package:socon/utils/fontSizes.dart';

class SogonMainScreen extends StatefulWidget {
  const SogonMainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SogonMainScreen();
  }
}

class _SogonMainScreen extends State<SogonMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              "소곤",
              style: TextStyle(fontSize: FontSizes.LARGE),
            ),
          ),
        ],
      ),
    );
  }
}
