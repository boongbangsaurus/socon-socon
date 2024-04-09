import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:socon/services/mystore_lists_service.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/tab.dart';
import 'package:socon/views/modules/my_store_lists.dart';
import 'package:socon/views/modules/my_store_analysis.dart';
import 'package:socon/viewmodels/menu.dart';
import 'package:socon/views/screens/stores/store_detail.dart';

class MyStoreListScreen extends StatefulWidget {
  const MyStoreListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyStoreListScreen();
  }
}

class _MyStoreListScreen extends State<MyStoreListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('소콘소콘'),
          actions: [],
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              child: TabBarScreen(
                  marginTop: 0,
                  tabHeight: ResponsiveUtils.getHeightWithPixels(context, 600),
                  contents: {
                    '내 점포': const MyStoreLists(),
                    // '점포 분석': MyStoreAnalysis(),
                    '구매 가능 소콘': StoreDetailScreen(storeId: 23),
                  }),
            ),
          ),
        ));
  }
}
