import 'package:flutter/material.dart';

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
    name: "늘솜꼬마김밥",
    imageUrl: "https://cataas.com/cat",
    address: "광주 광산구 장덕로40번길 13-1 1층",
    category: "음식점",
    createdAt: "YYYY-MM-DD",
    isLike: true,
    mainSocon: "소금빵",
    distance: 15);

List<Store> stores = [tempStore, tempStore, tempStore, tempStore, tempStore];
