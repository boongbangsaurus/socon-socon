import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 화면 해상도에 따라 화면의 너비, 높이, 폰트의 크기를 반응형으로 조정하는 utils
/// author : 김아현
class ResponsiveUtils {
  // 피그마에서 설정한 안드로이드 기준 사이즈
  static Map<String, num> androidSize = {
    'height': 800,
    'width': 360,
  };

  /// 주어진 너비(픽셀)를 퍼센트로 변경하고 다시 반응형 너비로 조정하는 메소드
  /// [context] : 현재의 BuildContext 값
  /// [width] : 변경하고자 하는 너비 값
  /// return : 반응형 너비
  static double getWidthWithPixels(BuildContext context, double width) {
    return (MediaQuery.of(context).size.width / androidSize['width']!) * width;
  }

  /// 주어진 높이(픽셀)를 퍼센트로 변경하고 다시 반응형 높이로 조정하는 메소드
  /// [context] : 현재의 BuildContext 값
  /// [height] : 변경하고자 하는 높이 값
  /// return : 반응형 높이
  static double getHeightWithPixels(BuildContext context, double height) {
    return (MediaQuery.of(context).size.height / androidSize['height']!) *
        height;
  }

  /// 주어진 비율을 화면의 너비의 해당하는 값으로 조정하는 메소드
  /// [context] : 현재의 BuildContext 값
  /// [percent] : 화면 너비의 몇 퍼센트를 계산할 지 나타내는 값
  /// return : 주어진 퍼센트에 해당하는 화면 너비
  static double getWidthPercent(BuildContext context, double percent) {
    return MediaQuery.of(context).size.width * (percent / 100);
  }

  /// 주어진 비율을 화면의 높이의 해당하는 값으로 조정하는 메소드
  /// [context] : 현재의 BuildContext 값
  /// [percent] : 화면 높이의 몇 퍼센트를 계산할 지 나타내는 값
  /// return : 주어진 퍼센트에 해당하는 화면 높이
  static double getHeightPercent(BuildContext context, double percent) {
    return MediaQuery.of(context).size.height * (percent / 100);
  }

  /// 반응형 폰트 크기를 계산하는 메소드
  /// [context]: 현재의 BuildContext 값
  /// [fontSize]: 계산하고자 하는 폰트 크기
  /// 반환 값: 반응형 폰트 크기
  static double calculateResponsiveFontSize(
      BuildContext context, double fontSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * (fontSize / androidSize['width']!);
  }
}
