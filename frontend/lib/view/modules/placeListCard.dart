import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/responsive_utils.dart';

class PlaceListCard extends StatefulWidget {
  const PlaceListCard({super.key});

  @override
  State<StatefulWidget> createState() => _PlaceListCardState();
}

class _PlaceListCardState extends State<PlaceListCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: ResponsiveUtils.getHeightWithPixels(context, 100)
          ),
          width: ResponsiveUtils.getWidthWithPixels(context, 320),
          color: AppColors.WARNING100,
          child: Container(
            child: Text("소콘 장소 카드야"),
          ),
        )
      ],
    );
  }
}
