import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/views/atoms/image_loader.dart';
import 'package:socon/views/modules/cards/publish_socon_card.dart';

import '../../models/menu.dart';
import '../../utils/colors.dart';
import '../../utils/icons.dart';
import '../../utils/responsive_utils.dart';
import '../atoms/dropdown.dart';

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
      color: AppColors.GRAY100,
      child: Stack(
        children: [
          Container(
            child: Image.network(widget.menu.imageUrl,
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  GoRouter.of(context).pop();
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
        PublishSoconCard(
          menu: widget.menu,
        ),
      ],
    );
  }
}
