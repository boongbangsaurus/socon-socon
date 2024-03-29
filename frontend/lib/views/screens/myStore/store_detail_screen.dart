import 'package:flutter/material.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/modules/store_detail_top_card.dart';
import '../../atoms/tab.dart';
import '../../modules/store_menu_management.dart';
import '../../modules/store_rigister_menu_lists.dart';

class StoreDetailScreen extends StatelessWidget {
  final String? pathParameter;

  const StoreDetailScreen(this.pathParameter, {super.key});

  @override
  Widget build(BuildContext context) {
    int storeId = int.parse(pathParameter!);
    return Scaffold(
      body: SingleChildScrollView(
        // SingleChildScrollView 추가
        child: Container(
          width: ResponsiveUtils.getWidthPercent(context, 100), // 너비를 100%로 설정
          child: Column(
            children: [
              StoreDetailTopCard(storeId: storeId),

              TabBarScreen(
                contents: {
                  '메뉴 관리': MenuManagement(storeId: storeId),
                  '발행 소콘': RegisteredMenu(storeId: storeId),
                },
                marginTop: 0,
                tabHeight: ResponsiveUtils.getHeightWithPixels(context, 580),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
