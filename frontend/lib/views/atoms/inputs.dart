import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';

/// 입력 필드 정의 클래스
///
/// [CustomTextFormField]
/// [getDecoration] : 입력 필드 스타일 설정
/// @param Widget? suffixs : 아이콘 등 오른쪽에 넣을 값
/// @return InputDecoration
/// [getCursorColor] : 입력 커서 컬러 설정
/// @return Color
/// [getCursorErrorColor] : 입력 에러 커서 컬러 설정
/// @return Color
/// [onTapOutsideHandler] : 포인트 이동시 설정
/// @return unfocusing
/// author: 탁하윤
class CustomTextFormField {
  // 입력 필드 위젯
  static Widget setCustomTextFormField({
    required String labelText,
    required TextFormField textFormField,
    String? hintText,
    String? helperText,
  }) {
    final String helper = helperText ?? "";
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                labelText,
                style: const TextStyle(
                    fontSize: FontSizes.SMALL, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 3.0,
              ),
              Text(
                helper,
                style: const TextStyle(
                    fontSize: FontSizes.XXSMALL, color: AppColors.GRAY400),
              ),
            ])),
        const SizedBox(
          height: 15.0,
        ),
        textFormField
      ],
    );
  }

  // 입력 필드 스타일 설정
  static InputDecoration getDecoration({Widget? suffixs}) {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.only(bottom: 0.0),
      errorStyle: const TextStyle(color: AppColors.ERROR400),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.GRAY300),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.YELLOW, width: 2.0),
      ),
      focusColor: AppColors.YELLOW,
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.ERROR400, width: 2.0),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.ERROR400),
      ),
      hoverColor: AppColors.YELLOW,
      suffixIcon: suffixs,
      suffixIconConstraints: BoxConstraints(maxHeight: 25, minHeight: 25),
    );
  }

  // TextFont 사이즈 설정
  static TextStyle getTextStyle() {
    return TextStyle(fontSize: FontSizes.XXSMALL);
  }

  // cursorColor 설정
  static Color getCursorColor() {
    return AppColors.YELLOW;
  }

  // cursorErrorColor 설정
  static Color getCursorErrorColor() {
    return AppColors.WARNING400;
  }

  // onTapOutside 설정
  static void onTapOutsideHandler(PointerDownEvent event) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
