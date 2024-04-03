import 'package:flutter/material.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/viewmodels/stores_view_model.dart';
import 'package:socon/views/atoms/checkbox.dart';
import 'package:socon/views/atoms/search_box.dart';

// type : "nearby" | "soconbook" | "like"
class SearchModule extends StatefulWidget {
  final String type;

  SearchModule({required this.type});

  @override
  _SearchModuleState createState() => _SearchModuleState();
}

class _SearchModuleState extends State<SearchModule> {
  bool isStoreNameChecked = false;
  bool isItemNameChecked = false;
  bool isCategoryChecked = false;
  bool isRoadAddressChecked = false;
  bool isGanadaChecked = false;
  bool isShortestDistanceChecked = false;

  StoresViewModel _storesViewModel = StoresViewModel();
  void handleEnterKey() {
    print('상호명: $isStoreNameChecked');
    print('상품명: $isItemNameChecked');
    print('카테고리: $isCategoryChecked');
    print('도로명 주소: $isRoadAddressChecked');
    print('가나다: $isGanadaChecked');
    print('최단거리: $isShortestDistanceChecked');

    _storesViewModel.searchStores();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveUtils.getWidthWithPixels(context, 320),
      // alignment: Alignment.center,
      child: SearchBox(
        filterAppliedWidget: widget.type == "soconbook"
            ? soconFilterBox(context)
            : nearbyFilterBox(context),
        onEnterPressed: handleEnterKey,
      ),
    );
  }

  Widget nearbyFilterBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.0),
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
                isChecked: isStoreNameChecked,
                onCheckedChanged: (isChecked) {
                  setState(() {
                    isStoreNameChecked = isChecked;
                  });
                  print("상호명 $isStoreNameChecked");
                },
              ),
              if (widget.type == "nearby") ...[
                CheckBoxBtn(
                  Text: "카테고리",
                  isChecked: isCategoryChecked,
                  onCheckedChanged: (isChecked) {
                    setState(() {
                      isCategoryChecked = isChecked;
                    });
                    print("카테고리 $isCategoryChecked");
                  },
                ),
                CheckBoxBtn(
                  Text: "도로명 주소",
                  isChecked: isRoadAddressChecked,
                  onCheckedChanged: (isChecked) {
                    setState(() {
                      isRoadAddressChecked = isChecked;
                    });
                    print("도로명 주소 $isRoadAddressChecked");
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
              if (widget.type == "nearby")
                CheckBoxBtn(
                  Text: "가나다",
                  isChecked: isGanadaChecked,
                  onCheckedChanged: (isChecked) {
                    setState(() {
                      isGanadaChecked = isChecked;
                    });
                    print("가나다 $isGanadaChecked");
                  },
                ),
              CheckBoxBtn(
                Text: "최단거리",
                isChecked: isShortestDistanceChecked,
                onCheckedChanged: (isChecked) {
                  setState(() {
                    isShortestDistanceChecked = isChecked;
                  });
                  print("최단거리 $isShortestDistanceChecked");
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
      padding: EdgeInsets.only(top: 5.0),
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
                isChecked: isStoreNameChecked,
                onCheckedChanged: (isChecked) {
                  setState(() {
                    isStoreNameChecked = isChecked;
                  });
                  print("상호명 $isStoreNameChecked");
                },
              ),
              CheckBoxBtn(
                Text: "상품명",
                isChecked: isItemNameChecked,
                onCheckedChanged: (isChecked) {
                  setState(() {
                    isItemNameChecked = isChecked;
                  });
                  print("상품명 $isItemNameChecked");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
