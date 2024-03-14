import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';

/// 버튼들을 정의하는 클래스
/// author: 탁하윤

// 큰 버튼
class LargeButton extends StatelessWidget {
  LargeButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.YELLOW),
      onPressed: onPressed,
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Text(
                text,
                style: const TextStyle(
                    color: AppColors.WHITE,
                    fontSize: FontSizes.XSMALL,
                    fontWeight: FontWeight.bold),
              )
            ],
          )),
    ));
  }
}
