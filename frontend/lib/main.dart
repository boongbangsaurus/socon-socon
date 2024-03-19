import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/view/atoms/searchBox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socon',
      theme: ThemeData(
          // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.amber),
          // primaryColor: AppColors.mainYellow
          // useMaterial3: true, // 이 줄을 주석 처리하거나 삭제하여 사용하시는 버전에 맞게 설정하세요.
          ),
      home: Scaffold(
        backgroundColor: AppColors.WHITE,
        body: Container(
          width: ResponsiveUtils.getWidthPercent(context, 100),
          height: ResponsiveUtils.getHeightPercent(context, 100),
          // decoration: BoxDecoration(
          //   border: Border.all(
          //     width:1.0,
          //     color: AppColors.WHITE
          //   )
          // ),
          child: Column(
            // 괄호 추가
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SearchBox(),
              Text(
                '소콘소콘',
                style: TextStyle(
                  fontFamily: "BagelFatOne",
                  fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                      context, FontSizes.LOGO),
                  color: AppColors.WHITE,
                ),
              ),
              Text(
                '소소한 우리 동네 기프티콘',
                style: TextStyle(
                  fontFamily: "Pretendard",
                  fontWeight: FontWeight.w500,
                  fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                      context, FontSizes.XSMALL),
                  color: AppColors.WHITE,
                ),
              ),
              // Container(
              //     width: ResponsiveUtils.getHeightWithPixels(context, 200),
              //     height: ResponsiveUtils.getHeightWithPixels(context, 60),
              //     color: AppColors.INDIGO200),
            ],
          ), // 괄호 추가
        ),
      ),
    );
  }
}
