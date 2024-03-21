import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/view/atoms/iconLoader.dart';
import 'package:socon/view/atoms/imageLoader.dart';
import 'package:socon/view/atoms/tag_icon.dart';

const imageUrl = "https://loremflickr.com/320/240";
const radius = 15.0;
const double cardHeight = 100.0;
const double imageContainerWidth = 77.0;
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
      margin: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
      color: AppColors.WHITE,
      height: cardHeight,
      width: ResponsiveUtils.getWidthWithPixels(context, 320),
      child: Row(
        children: <Widget>[
          Container(
            width: ResponsiveUtils.getWidthWithPixels(
                context, imageContainerWidth),
            height: ResponsiveUtils.getWidthWithPixels(
                context, imageContainerWidth),
            decoration: BoxDecoration(
              color: AppColors.WHITE,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const ImageLoader(
              imageUrl: "https://cataas.com/cat",
              borderRadius: 15.0,
            ),
          ),
          const SizedBox(width: horizontalSpacing),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: verticalSpacing),
              height: cardHeight,
              color: AppColors.WHITE,
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
    return Container(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("오소유",
                  style: TextStyle(
                      fontSize: FontSizes.SMALL, fontWeight: FontWeight.w800)),
              IconLoader(iconName: 'heart_empty', width: 14.0, height: 14.0),
            ],
          ),
          Text("광주 광산구 장덕로40번길 13-1 1층",
              style: TextStyle(
                  fontSize: FontSizes.XXXSMALL, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }

  Widget buildTagsAndDistance() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            TagIcon(
              buttonText: '빵집',
              buttonColor: AppColors.YELLOW,
              buttonTextColor: AppColors.WHITE,
            ),
            SizedBox(width: 10.0),
            TagIcon(
              buttonText: '소금빵',
              buttonColor: AppColors.YELLOW,
              buttonTextColor: AppColors.WHITE,
            ),
          ],
        ),
        Text("15m",
            style: TextStyle(
                fontSize: FontSizes.XXXSMALL, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
