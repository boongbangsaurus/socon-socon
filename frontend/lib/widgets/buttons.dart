import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';

/// 버튼 정의 클래스
/// author: 탁하윤

/// 노란색 큰 버튼
/// text: [필수] 버튼 텍스트 지정
/// onPressed: [필수] 버튼 onPressed 함수
class LargeButton extends StatelessWidget {
  LargeButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // return ButtonTheme(
    //   height: 60,
    //     child: ElevatedButton(
    //   style: ElevatedButton.styleFrom(backgroundColor: AppColors.YELLOW),
    //   onPressed: onPressed,
    //   child: Padding(
    //       padding: const EdgeInsets.all(20.0),
    //       child: Row(
    //         children: [
    //           Text(
    //             text,
    //             style: const TextStyle(
    //                 color: AppColors.WHITE,
    //                 fontSize: FontSizes.XSMALL,
    //                 fontWeight: FontWeight.bold),
    //           )
    //         ],
    //       )),
    // ));
    return SizedBox(
      height: 60,
      width: 330,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: AppColors.WHITE,
                fontSize: FontSizes.XSMALL,
                fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.YELLOW),
      ),
    );
  }
}
