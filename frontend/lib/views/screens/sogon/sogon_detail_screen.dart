import 'package:flutter/material.dart';
import 'package:socon/views/modules/app_bar.dart';

class SogonDetailScreen extends StatefulWidget {
  const SogonDetailScreen({super.key});

  @override
  State<SogonDetailScreen> createState() => _SogonDetailScreenState();
}

class _SogonDetailScreenState extends State<SogonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarWithArrow(
          title: '소곤',
        ),
        body: Column(
          children: [],
        ));
  }
}
