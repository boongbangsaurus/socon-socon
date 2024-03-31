// 상세설명, 유의사항 카드

import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/fontSizes.dart';
import '../../../utils/responsive_utils.dart';

class DetailInfoCard extends StatelessWidget {
  final String title;
  final String contents;
  final double width; // ResponsiveUtils.getWidthWithPixels(context, width) 에 넣을 width 값
  const DetailInfoCard({super.key, this.title = "상세설명", required this.contents,  this.width = 330});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.WHITE,
      ),
      width: ResponsiveUtils.getWidthWithPixels(context, width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                    context, FontSizes.XSMALL)),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
             "$contents",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                      context, FontSizes.XXXSMALL)),
              textAlign: TextAlign.left)
        ],
      ),
    );
  }
}
