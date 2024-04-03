import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/views/atoms/image_card.dart';
import 'package:socon/views/modules/app_bar.dart';
import 'package:socon/views/modules/search_module.dart';

import '../../models/store.dart';
import '../../utils/responsive_utils.dart';
import '../../viewmodels/stores_view_model.dart';
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
  late List<Store> stores = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<StoresViewModel>(context, listen: false).searchStores();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      appBar: CustomAppBar(title: "소콘소콘"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 상태가 변경될 때만 해당 부분을 다시 빌드하도록 Consumer를 사용
            Consumer<StoresViewModel>(
              builder: (context, viewModel, _) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 5.0),
                  alignment: Alignment.center,
                  width: ResponsiveUtils.getWidthWithPixels(context, 320),
                  child: availableSoconInfo(viewModel),
                );
              },
            ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget availableSoconInfo(StoresViewModel viewModel) {
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
}



