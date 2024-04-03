import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/icon_loader.dart';

import '../../utils/icons.dart';

class AddMenuCard extends StatelessWidget {
  int storeId;

  AddMenuCard({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("상품 등록");
        GoRouter.of(context).go("/myStores/${storeId}/register");
      },
      child: Container(
        width: ResponsiveUtils.getWidthWithPixels(context, 154),
        height: ResponsiveUtils.getHeightWithPixels(context, 182),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.WHITE,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 0,
                blurRadius: 5.0,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              AppIcons.PLUS,
              size: ResponsiveUtils.getWidthWithPixels(context, 32),
            ),
            Text(
              "상품 등록",
              style: TextStyle(
                  fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                      context, FontSizes.SMALL),
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
