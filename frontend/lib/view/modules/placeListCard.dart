import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/view/atoms/imageLoader.dart';

import '../atoms/tag_icon.dart';

const imageUrl = "https://loremflickr.com/320/240";
const radius = 15.0;

class PlaceListCard extends StatefulWidget {
  const PlaceListCard({super.key});

  @override
  State<StatefulWidget> createState() => _PlaceListCardState();
}

class _PlaceListCardState extends State<PlaceListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.INDIGO400,
      height: 120,
      width: ResponsiveUtils.getWidthWithPixels(context, 320),
      child: Row(
        children: <Widget>[
          Container(
            width: ResponsiveUtils.getWidthWithPixels(context, 77),
            height: ResponsiveUtils.getHeightWithPixels(context, 77),
            color: AppColors.LIGHTBLUE,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
              height: ResponsiveUtils.getHeightWithPixels(context, 77),
              color: AppColors.WARNING100,
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Container(),
                  ),
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              TagIcon(
                                  buttonText: '빵집',
                                  buttonColor: AppColors.YELLOW,
                                  buttonTextColor: AppColors.WHITE),
                              SizedBox(width: 10.0),
                              TagIcon(
                                  buttonText: '소금빵',
                                  buttonColor: AppColors.YELLOW,
                                  buttonTextColor: AppColors.WHITE),
                            ],
                          ),
                          Text("15m")
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
