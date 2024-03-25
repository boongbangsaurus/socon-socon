import 'package:flutter/material.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/icon_loader.dart';
import 'package:socon/views/modules/app_bar.dart';

import '../../utils/colors.dart';
import '../../utils/fontSizes.dart';
import '../../utils/icons.dart';

class MyInfoScreen extends StatefulWidget {
  final String userName;
  final int soconMoney;

  const MyInfoScreen(
      {super.key, this.userName = "김싸피", this.soconMoney = 3500});

  @override
  State<StatefulWidget> createState() {
    return _MyInfoScreen();
  }
}

class _MyInfoScreen extends State<MyInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "내 정보"),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          userInfo(),
        ],
      )),
    );
  }

  Widget userInfo() {
    return Column(
      children: [
        // 김싸피님
        Container(
          padding: EdgeInsets.only(bottom: 15.0),
          width: ResponsiveUtils.getWidthWithPixels(context, 320),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: IconLoader(
                  iconName: "avatar",
                  width: ResponsiveUtils.getWidthWithPixels(context, 36),
                  height: ResponsiveUtils.getWidthWithPixels(context, 36),
                ),
              ),
              Text(
                "${widget.userName} 님",
                style: TextStyle(
                  fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                      context, FontSizes.XLARGE),
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Icon(
                  AppIcons.EDIT, // 클래스명.변수명
                  size:
                      ResponsiveUtils.getWidthWithPixels(context, 15), // 사이즈 설정
                ),
              )
            ],
          ),
        ),

        // 소콘머니
        Container(
            width: ResponsiveUtils.getWidthWithPixels(context, 320),
            height: ResponsiveUtils.getHeightWithPixels(context, 90),
            decoration: BoxDecoration(
              color: AppColors.YELLOW,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "소콘머니",
                            style: TextStyle(
                              fontSize:
                                  ResponsiveUtils.calculateResponsiveFontSize(
                                      context, FontSizes.XXSMALL),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${widget.soconMoney} 원",
                            style: TextStyle(
                              fontSize:
                                  ResponsiveUtils.calculateResponsiveFontSize(
                                      context, FontSizes.XLARGE),
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                      Icon(
                        AppIcons.RIGHT,
                        size: ResponsiveUtils.getWidthWithPixels(context, 25),
                      )
                    ],
                  )
                ],
              ),
            )),

        const SizedBox(height: 20.0),
        // 소콘, 소곤 기록
        SizedBox(
          width: ResponsiveUtils.getWidthWithPixels(context, 320),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("보유 소콘",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                            context, FontSizes.XSMALL),
                        fontWeight: FontWeight.w400,
                      )),
                  Text("15",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                            context, FontSizes.XSMALL),
                        fontWeight: FontWeight.w700,
                      )),
                ],
              ),
              Column(
                children: [
                  Text("작성 소곤",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                            context, FontSizes.XSMALL),
                        fontWeight: FontWeight.w400,
                      )),
                  Text(
                    "1",
                    style: TextStyle(
                      fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                          context, FontSizes.XSMALL),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("댓글 소곤",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                            context, FontSizes.XSMALL),
                        fontWeight: FontWeight.w400,
                      )),
                  Text(
                    "0",
                    style: TextStyle(
                      fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                          context, FontSizes.XSMALL),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
