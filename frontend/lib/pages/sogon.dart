import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socon/widgets/socon_mysocon.dart';



class Sogon extends StatelessWidget {
  const Sogon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(child: MySocon(soconName: '소금빵', storeName: '오소유', dueDate: '2024-09-23',)),
          Flexible(child: MySocon(soconName: '소금빵', storeName: '오소유', dueDate: '2024-09-23',)),
        ],
      ),
    );
  }
}
