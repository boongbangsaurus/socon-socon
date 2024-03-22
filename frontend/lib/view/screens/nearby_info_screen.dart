import 'package:flutter/material.dart';
import 'package:socon/view/atoms/icon_loader.dart';
import 'package:socon/view/atoms/image_card.dart';

import '../../models/store.dart';
import '../../utils/responsive_utils.dart';
import '../atoms/search_box.dart';
import '../modules/place_list.dart';

class NearbyInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NearbyInfoScreen();
  }
}

class _NearbyInfoScreen extends State<NearbyInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Toast"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SearchBox(),
            ImageCard(
              imgUrl: "https://firebasestorage.googleapis.com/v0/b/socon-socon.appspot.com/o/images%2Fbanner%2Fbanner_maratang.png?alt=media&token=c3ac6662-a3da-49f1-b02b-b7c3db771180",
              width: ResponsiveUtils.getWidthWithPixels(context, 320),
              height: ResponsiveUtils.getHeightWithPixels(context, 88),
            ),
            // ElevatedButton(
            //   child: const Text("Show Toast"),
            //   onPressed: () {
            //     ToastUtil.showCustomToast(context, "availableSocon");
            //   },
            // ),
            SizedBox(height: ResponsiveUtils.getWidthWithPixels(context, 10.0)),
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
    storeId: 0,
    name: "오소유",
    imageUrl: "https://cataas.com/cat",
    address: "광주 광산구 장덕로40번길 13-1 1층",
    category: "음식점",
    createdAt: "2024-03-22",
    isLike: true,
    mainSocon: "소금빵",
    distance: 15);

List<Store> stores = List.generate(10, (index) => tempStore);
