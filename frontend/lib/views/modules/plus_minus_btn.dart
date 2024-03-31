import 'package:flutter/material.dart';
import 'package:socon/utils/responsive_utils.dart';

class PlusMinusButton extends StatefulWidget {
  @override
  _PlusMinusButtonState createState() => _PlusMinusButtonState();
}

class _PlusMinusButtonState extends State<PlusMinusButton> {
  int num = 0;

  @override
  Widget build(BuildContext context) {
    double iconSize = ResponsiveUtils.getWidthWithPixels(context, 30);
    return Container(
      child: Row(
        children: [
          Container(
            width: iconSize,
            height: iconSize,
            alignment: Alignment.center,
            child: IconButton(
              alignment: Alignment.center,
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  num--;
                  print("빼기");
                });
              },
            ),
          ),
          SizedBox(width: 8.0),
          Container(
            width: iconSize,
            height: iconSize,
            alignment: Alignment.center,
            child: Text(
              "$num",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0, // 원하는 폰트 사이즈로 변경하세요
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Container(
            width: iconSize,
            height: iconSize,
            alignment: Alignment.center,
            child: IconButton(
              alignment: Alignment.center,
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  num++;
                  print("더하기");
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

