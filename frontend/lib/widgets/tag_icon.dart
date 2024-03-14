import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



// 지정값 : 세로 크기, 텍스트 크기, 텍스트 굵기
class TagIcon extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;

  const TagIcon({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.0,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            color: buttonTextColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}



// 지정값 : 버튼 죄소 가로/세로 크기, 텍스트 크기, 텍스트 굵기
class TagButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final VoidCallback onPressed;

  final double minWidth;
  final double minHeight;


  const TagButton({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onPressed,
    this.minWidth = 10.0, // 최소 가로 크기
    this.minHeight = 30.0, // 최소 세로 크기
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        minimumSize: Size(minWidth, minHeight), // 최소 크기 설정
        // padding: EdgeInsets.all(0),
      ),
      child: Text(buttonText, style: TextStyle( color: buttonTextColor, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}

