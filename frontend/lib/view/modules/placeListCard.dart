import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/view/atoms/iconLoader.dart';
import 'package:socon/view/atoms/imageLoader.dart';
import 'package:socon/view/atoms/tag_icon.dart';

const imageUrl = "https://loremflickr.com/320/240";
const radius = 15.0;
const double cardHeight = 120.0;
const double imageContainerWidth = 70.0;
const double horizontalSpacing = 10.0;
const double verticalSpacing = 10.0;

class PlaceListCard extends StatefulWidget {
  const PlaceListCard({super.key});

  @override
  State<StatefulWidget> createState() => _PlaceListCardState();
}

class _PlaceListCardState extends State<PlaceListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveUtils.getHeightWithPixels(context, ResponsiveUtils.getHeightWithPixels(context, 5.0))),
      color: AppColors.WHITE,
      // color: AppColors.INDIGO200,
      height: ResponsiveUtils.getHeightWithPixels(context, 100),
      width: ResponsiveUtils.getWidthWithPixels(context, 360),
      child: Row(
        children: <Widget>[
          Container(
            width: ResponsiveUtils.getWidthWithPixels(
                context, imageContainerWidth),
            height: ResponsiveUtils.getWidthWithPixels(
                context, imageContainerWidth),
            decoration: BoxDecoration(
              color: AppColors.WHITE,
              // color: AppColors.ERROR200,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const ImageLoader(
              imageUrl: "https://cataas.com/cat",
              borderRadius: 15.0,
            ),
          ),
          const SizedBox(width: 10.0 ),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(right: ResponsiveUtils.getWidthWithPixels(context, 5.0)),
              height: ResponsiveUtils.getWidthWithPixels(context, imageContainerWidth),
              color: AppColors.WHITE,
              // color: AppColors.WARNING100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: buildPlaceInfo(),
                  ),
                  Expanded(
                    flex: 1,
                    child: buildTagsAndDistance(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPlaceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "오소유",
                overflow: TextOverflow.ellipsis, // Add this line
                style: TextStyle(
                  fontSize: ResponsiveUtils.calculateResponsiveFontSize(context, FontSizes.SMALL),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            IconLoader(iconName: 'heart_empty', width: ResponsiveUtils.getWidthWithPixels(context, 14), height: ResponsiveUtils.getWidthWithPixels(context, 14)),
          ],
        ),
        // SizedBox(height: ResponsiveUtils.getHeightWithPixels(context, 3.0)), // Add some spacing between the two texts
        Expanded(
          child: Text(
            "광주 광산구 장덕로40번길 13-1 1층",
            overflow: TextOverflow.ellipsis, // Add this line
            style: TextStyle(
              fontSize: ResponsiveUtils.calculateResponsiveFontSize(context, FontSizes.XXXSMALL),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }


  Widget buildTagsAndDistance( ) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            TagIcon(
              buttonText: '빵집',
              buttonColor: AppColors.YELLOW,
              buttonTextColor: AppColors.WHITE,
            ),
            SizedBox(width: 8.0),
            TagIcon(
              buttonText: '소금빵',
              buttonColor: AppColors.YELLOW,
              buttonTextColor: AppColors.WHITE,
            ),
          ],
        ),
        Text("15m",
            style: TextStyle(
                fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                    context, FontSizes.XXXSMALL), fontWeight: FontWeight.w500)),
      ],
    );
  }
}