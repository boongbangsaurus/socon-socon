import 'package:flutter/material.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/icons.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/viewmodels/socon_coupon_view_model.dart';
import 'package:socon/views/atoms/qr_code.dart';

import '../../utils/colors.dart';

class SoconCouponCard extends StatelessWidget {
  const SoconCouponCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: AppColors.WHITE,
      ),
      width: ResponsiveUtils.getWidthWithPixels(context, 330),
      height: ResponsiveUtils.getHeightWithPixels(context, 435),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "국밥집",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                    context, FontSizes.XXSMALL)),
          ),
          Text(
            "육개장",
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                    context, FontSizes.XLARGE)),
          ),
          const SizedBox(
            height: 25,
          ),
          QrCodeSocon(soconId: 1),
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "구매일",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                          context, FontSizes.XXSMALL)),
                ),
                Text(
                  "2024-03-02",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                          context, FontSizes.XXSMALL)),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "유효기간",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                          context, FontSizes.XXSMALL)),
                ),
                Text(
                  "2024-09-23",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                          context, FontSizes.XXSMALL)),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "사용처",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                          context, FontSizes.XXSMALL)),
                ),
                Text(
                  "국밥집",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                          context, FontSizes.XXSMALL)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SoconCoupon extends StatelessWidget {
  final VoidCallback onPressed;
  final GlobalKey _repaintBoundaryKey = GlobalKey();
  final SoconCouponViewModel _soconCouponViewModel = SoconCouponViewModel();

  SoconCoupon({this.onPressed = _defaultOnPressed});

  static void _defaultOnPressed() {
    print("mySocon입니다.");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: ResponsiveUtils.getWidthPercent(context, 100),
        height: ResponsiveUtils.getHeightWithPixels(context, 520),
        color: AppColors.YELLOW,
        child: Column(
          children: [
            SizedBox(height: ResponsiveUtils.getHeightWithPixels(context, 20)),
            RepaintBoundary(
              key: _repaintBoundaryKey,
              child: SoconCouponCard(),
            ),
            SizedBox(
              height: ResponsiveUtils.getHeightWithPixels(context, 15),
            ),
            GestureDetector(
              onTap: () => {
                print("소곤 교환권 저장"),
                _soconCouponViewModel.captureAndSaveImage(_repaintBoundaryKey),
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: AppColors.WHITE,
                ),
                width: ResponsiveUtils.getWidthWithPixels(context, 330),
                height: ResponsiveUtils.getHeightWithPixels(context, 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      AppIcons.DOWNLOAD,
                      size: ResponsiveUtils.getWidthWithPixels(context, 14),
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      "교환권 저장",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                              context, FontSizes.XXXSMALL)),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: ResponsiveUtils.getHeightWithPixels(context, 15),
            ),
          ],
        ));
  }
}
