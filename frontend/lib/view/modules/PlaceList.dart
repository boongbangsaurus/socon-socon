import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/view/modules/placeListCard.dart';

class PlaceList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: ResponsiveUtils.getWidthWithPixels(context, 320),
          height: ResponsiveUtils.getHeightPercent(context, 50),
          color: AppColors.INDIGO200,
          child: PlaceListCard(),
        )
      ],
    );
  }
}