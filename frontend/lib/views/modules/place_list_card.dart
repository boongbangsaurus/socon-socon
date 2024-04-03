import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/models/store.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/icon_loader.dart';
import 'package:socon/views/atoms/image_loader.dart';
import 'package:socon/views/atoms/tag_icon.dart';

// 상수 정의: imageUrl, borderRadius, 이미지 컨테이너 너비
const imageUrl = "https://cataas.com/cat";
const borderRadius = 15.0;
const double imageContainerWidth = 70.0;

// 장소 목록 카드 위젯
class PlaceListCard extends StatefulWidget {
  final Store storeInfo;

  const PlaceListCard({super.key, required this.storeInfo});

  @override
  State<StatefulWidget> createState() => _PlaceListCardState();
}

// 장소 목록 카드 상태 클래스
class _PlaceListCardState extends State<PlaceListCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = false;
  }

  @override
  Widget build(BuildContext context) {
    // print('ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ');
    // print(widget.storeInfo.storeId);
    return GestureDetector(
      onTap: () {
        print("장소리스트 클릭 ${widget.storeInfo.storeId}");
        GoRouter.of(context).go("/detail/${widget.storeInfo.storeId}");
      },
      child: Container(
        margin: EdgeInsets.only(
            bottom: ResponsiveUtils.getHeightWithPixels(
                context, ResponsiveUtils.getHeightWithPixels(context, 5.0))),
        color: AppColors.WHITE,
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
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: const ImageLoader(
                imageUrl: "https://cataas.com/cat",
                borderRadius: borderRadius,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                    right: ResponsiveUtils.getWidthWithPixels(context, 5.0)),
                height: ResponsiveUtils.getWidthWithPixels(
                    context, imageContainerWidth),
                color: AppColors.WHITE,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: buildPlaceInfo(), // 장소 정보 위젯
                    ),
                    Expanded(
                      flex: 1,
                      child: buildTagsAndDistance(), // 태그 및 거리 위젯
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 장소 정보 위젯
  Widget buildPlaceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.storeInfo.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                      context, FontSizes.SMALL),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            IconLoader(
              iconName: isFavorite ? 'heart_fill' : 'heart_empty',
              width: ResponsiveUtils.getWidthWithPixels(context, 14),
              height: ResponsiveUtils.getWidthWithPixels(context, 14),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite; // 상태 변경
                });
                print(isFavorite ? "관심 가게로 등록" : "관심 가게 해제");
              },
            ),
          ],
        ),
        Expanded(
          child: Text(
            '${widget.storeInfo.address}m',
            // overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                  context, FontSizes.XXXSMALL),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // 태그 및 거리 위젯
  Widget buildTagsAndDistance() {
    final String mainSocon = widget.storeInfo.mainSocon;
    final String category = widget.storeInfo.category;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            TagIcon(
              buttonText: category,
              buttonColor: AppColors.YELLOW,
              buttonTextColor: AppColors.WHITE,
            ),
            const SizedBox(width: 8.0),
            TagIcon(
              buttonText: mainSocon,
              buttonColor: AppColors.YELLOW,
              buttonTextColor: AppColors.WHITE,
            ),
          ],
        ),
        Text(widget.storeInfo.distance.toString(),
            style: TextStyle(
                fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                    context, FontSizes.XXXSMALL),
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}

// author: 김아현
