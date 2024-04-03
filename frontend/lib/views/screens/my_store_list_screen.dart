import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:socon/services/mystore_lists_service.dart';
import 'package:socon/views/atoms/tab.dart';
import 'package:socon/views/modules/my_store_lists.dart';
import 'package:socon/views/modules/my_store_analysis.dart';
import 'package:socon/viewmodels/mystore_lists_view_model.dart';

class MyStoreListScreen extends StatefulWidget {
  const MyStoreListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyStoreListScreen();
  }
}

class _MyStoreListScreen extends State<MyStoreListScreen> {
  List<dynamic> myStores = [];

  @override
  void initState() {
    super.initState();
    loadMyStores();
  }

  void loadMyStores() async {
    debugPrint('내 점포리스트 요청중!');
    MystoreListsService service = MystoreListsService();
    var stores = await service.getMystoreLists();
    // debugPrint(stores as String?);
    setState(() {
      myStores = stores;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('8888888888888888888888888');
    print(myStores);
    print('8888888888888888888888888');

    return Scaffold(
        appBar: AppBar(
          title: Text('소콘소콘'),
          actions: [],
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              child: TabBarScreen(marginTop: 0, tabHeight: 600, contents: {
                '내 점포': MyStoreLists(),
                '점포 분석': MyStoreAnalysis(),
              }),
            ),
          ),
        ));
  }
}
