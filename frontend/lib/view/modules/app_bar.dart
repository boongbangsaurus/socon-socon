import 'package:flutter/material.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/view/atoms/icon_loader.dart';

import '../../utils/colors.dart';

// 종류 : 소콘소콘, 관심 가게, 내 정보
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({this.title = "소콘소콘"});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.WHITE,
      elevation: 0,
      // automaticallyImplyLeading: false,
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                context, FontSizes.LARGE)),
      ),
      actions: [
        IconLoader(
          iconName: "heart_empty",
          width: ResponsiveUtils.getWidthWithPixels(context, 20),
          height: ResponsiveUtils.getHeightWithPixels(context, 20),
          onPressed: () {
            print('관심 가게로 이동');
          },
        ),
        SizedBox(width: 10.0),
        IconLoader(
          iconName: "notifications",
          width: ResponsiveUtils.getWidthWithPixels(context, 24),
          height: ResponsiveUtils.getHeightWithPixels(context, 24),
          onPressed: () {
            print('알림함으로 이동');
          },
        ),
        SizedBox(width: ResponsiveUtils.getWidthWithPixels(context, 17))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//
class CustomAppBarWithArrow extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  CustomAppBarWithArrow({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: Border(
        bottom: BorderSide(
          color: AppColors.GRAY200,
          width: 1,
        )
      ),
      scrolledUnderElevation: 0,
      // backgroundColor: Colors.transparent,
      backgroundColor: AppColors.WHITE,
      elevation: 0,
      // automaticallyImplyLeading: false,
      leading: IconLoader(
        iconName: "arrow_back",
        padding: ResponsiveUtils.getWidthWithPixels(context, 15),
        onPressed: () {
          print('이전 화면으로 이동');
        },
      ),
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                context, FontSizes.SMALL)),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
