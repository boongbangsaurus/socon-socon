import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/views/atoms/image_card.dart';
import 'package:socon/views/modules/app_bar.dart';
import 'package:socon/views/modules/search_module.dart';

import '../../models/store.dart';
import '../../utils/responsive_utils.dart';
import '../atoms/search_box.dart';
import '../modules/place_list.dart';

// 주변 장소 조회 페이지
class NearbyInfoScreen extends StatefulWidget {
  final String userName = "도휘리릭";
  final int number = 100;

  @override
  State<StatefulWidget> createState() {
    return _NearbyInfoScreen();
  }
}

class _NearbyInfoScreen extends State<NearbyInfoScreen> {
  Widget availableSoconInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "${widget.userName}님, 현재 사용 가능한 소콘이",
          style: TextStyle(
            fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                context, FontSizes.XXXSMALL),
            color: AppColors.BLACK,
          ),
        ),
        Text(
          "${widget.number}",
          style: TextStyle(
            fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                context, FontSizes.SMALL),
          ),
        ),
        Text(
          "개 남아있어요.",
          style: TextStyle(
            fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                context, FontSizes.XXXSMALL),
            color: AppColors.BLACK,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      appBar: CustomAppBar(title : "소콘소콘"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 5.0),
                alignment: Alignment.center,
                width: ResponsiveUtils.getWidthWithPixels(context, 320),
                child: availableSoconInfo()),
            ImageCard(
              imgUrl:
                  "https://firebasestorage.googleapis.com/v0/b/socon-socon.appspot.com/o/images%2Fbanner%2Fbanner_maratang.png?alt=media&token=c3ac6662-a3da-49f1-b02b-b7c3db771180",
              width: ResponsiveUtils.getWidthWithPixels(context, 320),
              height: ResponsiveUtils.getHeightWithPixels(context, 88),
            ),

            const SizedBox(height: 15.0),
            SearchModule(type: "nearby"),
            SizedBox(height: 10.0),
            Expanded(
                child: SizedBox(
              width: ResponsiveUtils.getWidthWithPixels(context, 320),
              child: PlaceList(stores: stores),
            ))
          ],
        ),
      ),
    );
  }
}

Store tempStore = Store(
    storeId: 20,
    name: "오소유",
    imageUrl: "https://cataas.com/cat",
    address: "광주 광산구 장덕로40번길 13-1 1층",
    category: "음식점",
    createdAt: "2024-03-22",
    isLike: true,
    mainSocon: "소금빵",
    distance: 15);

List<Store> stores = List.generate(10, (index) {
  return Store(
    storeId: tempStore.storeId + index,
    name: tempStore.name,
    imageUrl: tempStore.imageUrl,
    address: tempStore.address,
    category: tempStore.category,
    createdAt: tempStore.createdAt,
    isLike: tempStore.isLike,
    mainSocon: tempStore.mainSocon,
    distance: tempStore.distance,
  );
});