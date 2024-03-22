import 'package:flutter/material.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/view/atoms/icon_loader.dart';

import '../../utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.WHITE,
      elevation: 0,
      // automaticallyImplyLeading: false,
      title: Text(
        "소콘소콘",
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
        SizedBox(width: ResponsiveUtils.getWidthWithPixels(context, 15))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
