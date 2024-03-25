import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';

/// 버튼 정의 클래스
/// 1. Basic Button
///   - xs: 70x30
///   - s: 150x60
///   - m: 280x60
///   - l: 320x60
/// author: 탁하윤
///
/// [BasicButton]
/// @param String [text] : 버튼 텍스트 지정
/// @param voidCallback? [onPressed] : 버튼 onPressed 함수, null: disable 상태
/// @param String? [color] : 버튼 색상 지정 null: yellow, yellow, gray, gray600 입력 가능
/// @param String? [textColor] : 버튼 텍스트 색상 지정 null: white, black, white입력 가능
/// @param String? [btnSize] : 버튼 사이즈 지정 null: 320x60, xs:70x30 s:150x60 m: l:320x60
/// @returns The new custom button
class BasicButton extends StatefulWidget {
  BasicButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.color,
    this.textColor,
    this.btnSize,
  }) : super(key: key);

  final String text; // 버튼 텍스트
  final String? color; // 버튼 색상
  final String? textColor; // 텍스트 색상
  final String? btnSize; // 버튼 사이즈
  final VoidCallback? onPressed; // 클릭 함수

  // sizes map: 버튼 사이즈 별 width, height, fontsize
  final sizes = {
    'xs': [70.0, 30.0, 10.0],
    's': [150.0, 60.0, FontSizes.XSMALL],
    'm': [280.0, 60.0, FontSizes.XSMALL],
    'l': [320.0, 60.0, FontSizes.XSMALL]
  };
  @override
  State<BasicButton> createState() => _BasicButtonState();
}

class _BasicButtonState extends State<BasicButton> {
  @override
  Widget build(BuildContext context) {
    // 버튼 색상 지정
    // 기본 yellow
    Color buttonColor = AppColors.YELLOW;
    if (widget.color == "yellow") {
      buttonColor = AppColors.YELLOW;
    } else if (widget.color == "gray") {
      buttonColor = AppColors.GRAY300;
    } else if (widget.color == "gray600") {
      buttonColor = AppColors.GRAY600;
    } else if (widget.color == null) {
      buttonColor = AppColors.YELLOW;
    }
    // 텍스트 색상 지정
    // 기본 white
    Color textColor = AppColors.WHITE;
    if (widget.textColor == "white") {
      textColor = AppColors.WHITE;
    } else if (widget.textColor == "black") {
      textColor = AppColors.BLACK;
    } else if (widget.textColor == null) {
      textColor = AppColors.WHITE;
    }
    // 버튼 크기 지정
    // 기본 320x60
    print(widget.btnSize);
    final btnSize = widget.btnSize ?? 'l';
    double buttonWidth =
        ResponsiveUtils.getWidthWithPixels(context, widget.sizes[btnSize]![0]);
    double buttonHeight =
        ResponsiveUtils.getHeightWithPixels(context, widget.sizes[btnSize]![1]);
    double fontSize = ResponsiveUtils.calculateResponsiveFontSize(
        context, widget.sizes[btnSize]![2]);
    // 버튼 라운드 설정
    // 기본 15
    double round = widget.btnSize != 'xs' ? 15 : 5;

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppColors.GRAY300,
          backgroundColor: buttonColor,
          surfaceTintColor: buttonColor,
          foregroundColor: AppColors.WHITE,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(round)),
          shadowColor: Colors.transparent,
        ),
        child: Text(widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
