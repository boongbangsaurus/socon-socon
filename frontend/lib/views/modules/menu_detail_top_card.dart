import 'package:flutter/material.dart';

import '../../models/menu.dart';
import '../../utils/colors.dart';
import '../../utils/icons.dart';
import '../../utils/responsive_utils.dart';

class MenuDetailTopCard extends StatefulWidget {
  final Menu menu;

  const MenuDetailTopCard({super.key, required this.menu});

  @override
  State<StatefulWidget> createState() => _MenuDetailTopCardState();
}

class _MenuDetailTopCardState extends State<MenuDetailTopCard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: AppColors.WHITE,
      child: Stack(
        children: [
          Container(
            child: Image.network('https://cataas.com/cat',
                fit: BoxFit.cover,
                height: ResponsiveUtils.getHeightWithPixels(context, 160),
                width: ResponsiveUtils.getWidthPercent(context, 100)),
          ),
          shortMenuInfoWithBar(context),
        ],
      ),
    ));
  }

  Widget shortMenuInfoWithBar(BuildContext context) {
    return Column(
      children: [
        // 매장 정보에 대한 상단 바
        Container(
          margin: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  // Navigator 이동 기능 주석 처리됨
                },
                icon: Icon(
                  AppIcons.LEADING, // 아이콘
                  color: AppColors.WHITE,
                  size: ResponsiveUtils.getWidthWithPixels(
                      context, 28.0), // 아이콘 크기
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  AppIcons.INFO, // 아이콘
                  color: AppColors.WHITE,
                  size: ResponsiveUtils.getWidthWithPixels(
                      context, 24.0), // 아이콘 크기
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ResponsiveUtils.getHeightWithPixels(context, 50)),
        shortMenuInfoCard(context),
      ],
    );
  }

  Widget shortMenuInfoCard(BuildContext context) {
    return // 매장 정보 카드
        Container(
      width: ResponsiveUtils.getWidthWithPixels(context, 330),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 10),
      // 상단 바와의 간격 추가
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [],
      ),
    );
  }
}
