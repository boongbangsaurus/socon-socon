import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';

/// [CustomModal]
/// 커스텀 모달 클래스
/// [showCustomDialog] 함수 정의
/// @param String [title] 팝업 타이틀
/// @param String [content] 팝업 내용
/// @param List<Widget> [actions] 버튼 리스트 위젯
/// @return custom AlertDialog
class CustomModal {
  static AlertDialog showCustomDialog({
    required String title,
    required String content,
    required List<Widget> actions,
  }) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style:
            TextStyle(fontSize: FontSizes.XLARGE, fontWeight: FontWeight.bold),
      ),
      content: Text(content,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: FontSizes.XXXSMALL)),
      actions: actions,
      backgroundColor: AppColors.WHITE,
      surfaceTintColor: Colors.transparent,
    );
  }
}
