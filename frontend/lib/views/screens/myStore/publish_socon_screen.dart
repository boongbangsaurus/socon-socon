import 'package:flutter/material.dart';
import 'package:socon/views/modules/menu_detail_top_card.dart';

import '../../../models/menu.dart';
import '../../../utils/colors.dart';
import '../../../utils/responsive_utils.dart';

class PublishSoconScreen extends StatefulWidget {
  final String menuId;
  final  String storeId;

  const PublishSoconScreen(this.menuId, this.storeId, {super.key});

  @override
  State<StatefulWidget> createState() => _PublishSoconScreenState();
}

class _PublishSoconScreenState extends State<PublishSoconScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      body: SingleChildScrollView(
        // SingleChildScrollView 추가
        child: Container(
          width: ResponsiveUtils.getWidthPercent(context, 100), // 너비를 100%로 설정
          child: Column(
            children: [
              Text("menuId ${widget.menuId}")
              // MenuDetailTopCard(menu: widget.menu),
            ],
          ),
        ),
      ),
    );
  }
}
