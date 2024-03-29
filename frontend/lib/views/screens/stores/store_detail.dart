import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/modules/store_detail_top_card.dart';


class StoreDetailScreen extends StatelessWidget {
  final String? pathParameter;

  const StoreDetailScreen(this.pathParameter, {super.key});

  @override
  Widget build(BuildContext context) {
    int storeId = int.parse(pathParameter!);
    bool isOwner = false;

    return Scaffold(
      backgroundColor: AppColors.WHITE,
      body: SingleChildScrollView(
        // SingleChildScrollView 추가
        child: Container(
          width: ResponsiveUtils.getWidthPercent(context, 100), // 너비를 100%로 설정
          child: Column(
            children: [
              StoreDetailTopCard(storeId: storeId, isOwner: isOwner),
              SizedBox(
                height: 15.0,
              ),
              Text('할인 소콘'),


            ],
          ),
        ),
      ),
    );
  }
}
