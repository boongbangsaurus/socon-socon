import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/views/atoms/image_card.dart';
import 'package:socon/views/modules/app_bar.dart';
import 'package:socon/views/modules/checkbox_group.dart';
import 'package:socon/views/modules/search_module.dart';

import '../../models/mystore_lists_model.dart';
import '../../models/store.dart';
import '../../utils/responsive_utils.dart';
import '../../viewmodels/stores_view_model.dart';
import '../atoms/search_box.dart';
import '../modules/place_list.dart';

// 주변 장소 조회 페이지
class NearbyInfoScreen extends StatefulWidget {
  final String userName = "도휘리릭";
  final int number = 100;

  const NearbyInfoScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NearbyInfoScreenState();
  }
}

class _NearbyInfoScreenState extends State<NearbyInfoScreen> {
  List<Store> stores = [];
  final StoresViewModel _storesViewModel = StoresViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadImage();
  }

  static String bannerUrl =
      "https://firebasestorage.googleapis.com/v0/b/socon-socon.appspot.com/o/images%2Fbanner%2Fbanner_maratang.png?alt=media&token=c3ac6662-a3da-49f1-b02b-b7c3db771180";

  void _preloadImage() {
    precacheImage(NetworkImage(bannerUrl), context);
  }

  Future<List<Store>?> _fetchStores() async {
    try {
      List<Store>? storesData = await _storesViewModel.searchStores();

      print("_fetchStores result: $storesData");
      return storesData;
    } catch (error) {
      print("Error _fetchStores: $error");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      appBar: CustomAppBar(title: "소콘소콘"),
      body: FutureBuilder<List<Store>?>(
        future: _fetchStores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Store>? storesData = snapshot.data;
            print("storesData를 찍어보자 $storesData");

            if (storesData != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    CheckBoxGroup(),
                    ImageCard(
                      imgUrl: bannerUrl,
                      width: ResponsiveUtils.getWidthWithPixels(context, 320),
                      height: ResponsiveUtils.getHeightWithPixels(context, 88),
                    ),

                    const SizedBox(height: 15.0),
                    SearchModule(type: "nearby"),
                    SizedBox(height: 10.0),
                    Expanded(
                      child: SizedBox(
                        width: ResponsiveUtils.getWidthWithPixels(context, 320),
                        child: PlaceList(stores: storesData),
                      ),
                    ),
                  ],
                ),
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

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
}
