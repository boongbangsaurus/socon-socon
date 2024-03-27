import 'package:flutter/material.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/checkbox.dart';
import 'package:socon/views/atoms/search_box.dart';

// type : "nearby" | "soconbook" | "like"
class SearchModule extends StatelessWidget {
  final String type;

  SearchModule({required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveUtils.getWidthWithPixels(context, 320),
      // alignment: Alignment.center,
      child: SearchBox(
        filterAppliedWidget: type == "soconbook" ?  soconFilterBox(context) : nearbyFilterBox(context),
      ),
    );
  }

  Widget nearbyFilterBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:5.0),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(
                  left: ResponsiveUtils.getWidthWithPixels(context, 10)),
              child: Text(
                "검색",
                style: TextStyle(
                  fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                      context, FontSizes.XXSMALL),
                  fontWeight: FontWeight.w400,
                ),
              )),
          Row(
            children: [
              CheckBoxBtn(
                Text: "상호명",
                isChecked: false,
                onCheckedChanged: (isChecked) {
                  print('Checkbox is checked: $isChecked');
                },
              ),
              if (type == "nearby") ...[
                CheckBoxBtn(
                  Text: "카테고리",
                  isChecked: false,
                  onCheckedChanged: (isChecked) {
                    print('Checkbox is checked: $isChecked');
                  },
                ),
                CheckBoxBtn(
                  Text: "도로명 주소",
                  isChecked: false,
                  onCheckedChanged: (isChecked) {
                    print('Checkbox is checked: $isChecked');
                  },
                )
              ]
            ],
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: ResponsiveUtils.getWidthWithPixels(context, 10)),
              child: Text(
                "정렬",
                style: TextStyle(
                  fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                      context, FontSizes.XXSMALL),
                  fontWeight: FontWeight.w400,
                ),
              )),
          Row(
            children: [
              if (type == "nearby")
                CheckBoxBtn(
                  Text: "최단거리",
                  isChecked: false,
                  onCheckedChanged: (isChecked) {
                    print('Checkbox is checked: $isChecked');
                  },
                ),
              CheckBoxBtn(
                Text: "가나다",
                isChecked: false,
                onCheckedChanged: (isChecked) {
                  print('Checkbox is checked: $isChecked');
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget soconFilterBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:5.0),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.only(
                  left: ResponsiveUtils.getWidthWithPixels(context, 10)),
              child: Text(
                "검색",
                style: TextStyle(
                  fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                      context, FontSizes.XXSMALL),
                  fontWeight: FontWeight.w400,
                ),
              )),
          Row(
            children: [
              CheckBoxBtn(
                Text: "상호명",
                isChecked: false,
                onCheckedChanged: (isChecked) {
                  print('Checkbox is checked: $isChecked');
                },
              ),
              CheckBoxBtn(
                Text: "상품명",
                isChecked: false,
                onCheckedChanged: (isChecked) {
                  print('Checkbox is checked: $isChecked');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
