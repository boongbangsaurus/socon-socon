import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/icon_loader.dart';
import 'package:socon/views/atoms/tag_icon.dart';
import 'package:socon/views/modules/app_bar.dart';

import '../../utils/colors.dart';
import '../../utils/fontSizes.dart';
import '../../utils/icons.dart';
import '../atoms/switch.dart';

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
  bool _enableNotification = false;
  bool _enableWatchNotification = true;
  bool _isOwnerVerified = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "내 정보"),
      body: Container(
        color: AppColors.GRAY100, // 배경색 지정
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                userInfo(),
                const SizedBox(
                  height: 20.0,
                ),
                appSetting(),
                const SizedBox(
                  height: 20.0,
                ),
                serviceSetting(context),
                const SizedBox(
                  height: 10.0,
                ),
                // appSetting(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget userInfo() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          ResponsiveUtils.getWidthWithPixels(context, 20),
          0,
          ResponsiveUtils.getWidthWithPixels(context, 20),
          0),
      decoration: BoxDecoration(
        color: AppColors.WHITE,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // 김싸피님
          Container(
            padding: EdgeInsets.only(bottom: 15.0),
            width: ResponsiveUtils.getWidthWithPixels(context, 360),
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
                    size: ResponsiveUtils.getWidthWithPixels(
                        context, 15), // 사이즈 설정
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
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget appSetting() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          ResponsiveUtils.getWidthWithPixels(context, 20),
          15,
          ResponsiveUtils.getWidthWithPixels(context, 20),
          15),
      decoration: BoxDecoration(
          color: AppColors.WHITE, borderRadius: BorderRadius.circular(10)),
      width: ResponsiveUtils.getWidthPercent(context, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "앱 설정",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                    context, FontSizes.MEDIUM)),
          ),
          const SizedBox(height: 15.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "알림",
                    style: TextStyle(
                        fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                            context, FontSizes.MEDIUM)),
                  ),
                  CustomSwitch(
                      value: _enableNotification,
                      onChanged: (bool val) {
                        setState(() {
                          _enableNotification = val;
                        });
                      })
                ],
              )
            ],
          ),
          const SizedBox(height: 15.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "워치 알림",
                    style: TextStyle(
                        fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                            context, FontSizes.MEDIUM)),
                  ),
                  CustomSwitch(
                      value: _enableWatchNotification,
                      onChanged: (bool val) {
                        setState(() {
                          _enableWatchNotification = val;
                        });
                      })
                ],
              )
            ],
          ),
          const SizedBox(height: 15.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "워치 연동",
                style: TextStyle(
                    fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                        context, FontSizes.MEDIUM)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget serviceSetting(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          ResponsiveUtils.getWidthWithPixels(context, 20),
          15,
          ResponsiveUtils.getWidthWithPixels(context, 20),
          15),
      decoration: BoxDecoration(
          color: AppColors.WHITE, borderRadius: BorderRadius.circular(10)),
      width: ResponsiveUtils.getWidthPercent(context, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "서비스",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                    context, FontSizes.MEDIUM)),
          ),
          const SizedBox(height: 15.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => {
                  print("사장님 인증 클릭"),
                  GoRouter.of(context).go('/info/verify')
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "사장님 인증",
                      style: TextStyle(
                          fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                              context, FontSizes.MEDIUM)),
                    ),
                    _isOwnerVerified
                        ? const TagIcon(
                            buttonText: "인증",
                            buttonColor: AppColors.SUCCESS500,
                            buttonTextColor: AppColors.WHITE,
                            width: 50,
                            height: 25,
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 15.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "개인정보 관리",
                style: TextStyle(
                    fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                        context, FontSizes.MEDIUM)),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "이용약관",
                style: TextStyle(
                    fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                        context, FontSizes.MEDIUM)),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => {
                  print("문의하기 클릭"),
                  GoRouter.of(context).go('/info/success')
                },
                child: Text(
                  "문의하기",
                  style: TextStyle(
                      fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                          context, FontSizes.MEDIUM)),
                ),
              )
            ],
          ),
          const SizedBox(height: 15.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "로그아웃",
                style: TextStyle(
                    fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                        context, FontSizes.MEDIUM)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
