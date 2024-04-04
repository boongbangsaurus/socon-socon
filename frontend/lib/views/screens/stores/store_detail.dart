import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socon/models/socon_card.dart';
import 'package:socon/services/mystore_detail_menu_list_service.dart';
import 'package:socon/services/payment_service.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/modules/mystore_menu_card.dart';
import 'package:socon/views/modules/socon_storesocon.dart';
import 'package:socon/views/payments/buy_socon_payment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 처리를 위한 패키지
import 'package:shared_preferences/shared_preferences.dart';

import '../../../viewmodels/mystore_detail_menu_list_view_model.dart       ';

final List<Socon> saleMenuList = [
  Socon.fromJson({
    "id": 0, // issue id
    "name": "소금빵",
    "price": 3000, // 정가(할인 전 가격)
    "is_main": true, // 대표 상품 여부
    "image": "https://cataas.com/cat",
    "issued_quantity": 3, // 현재 발행량 (구매된 갯수)
    "left_quantity": 4, // 남은 갯수
    "is_discounted": true, // 할인 여부
    "discounted_price": 2500, // 할인 적용된 가격
    // "created_at": 2024-03-24 // 발행 정보 등록된 날짜
  }),
  Socon.fromJson({
    "id": 1, // issue id
    "is_main": false, // 대표 상품 여부
    "name": "소금빵",
    "image": "https://cataas.com/cat",
    "issued_quantity": 3, // 현재 발행량 (구매된 갯수)
    "left_quantity": 4, // 남은 갯수
    "is_discounted": true, // 할인 여부
    "price": 3000, // 정가(할인 전 가격)
    "discounted_price": 2500, // 할인 적용된 가격
    // "created_at": 2024-03-24 // 발행 정보 등록된 날짜
  }),
  Socon.fromJson({
    "id": 2, // issue id
    "is_main": false, // 대표 상품 여부
    "name": "소금빵",
    "image": "https://cataas.com/cat",
    "issued_quantity": 3, // 현재 발행량 (구매된 갯수)
    "left_quantity": 4, // 남은 갯수
    "is_discounted": false, // 할인 여부
    "price": 3000, // 정가(할인 전 가격)
    "discounted_price": 2500, // 할인 적용된 가격
    // "created_at": 2024-03-24 // 발행 정보 등록된 날짜
  }),
  Socon.fromJson({
    "id": 3, // issue id
    "is_main": false, // 대표 상품 여부
    "name": "소금빵",
    "image": "https://cataas.com/cat",
    "issued_quantity": 3, // 현재 발행량 (구매된 갯수)
    "left_quantity": 4, // 남은 갯수
    "is_discounted": false, // 할인 여부
    "price": 3000, // 정가(할인 전 가격)
    "discounted_price": 2500, // 할인 적용된 가격
    // "created_at": 2024-03-24 // 발행 정보 등록된 날짜
  }),
];


class StoreDetailScreen extends StatefulWidget {
  final int storeId;

  StoreDetailScreen({required this.storeId, super.key});

  @override
  State<StoreDetailScreen> createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  // int test = int.parse(widget.pathParameter!);

  // Map<String, dynamic> storeInfos = {};
  List<dynamic> storeInfos = [];
  List<dynamic> discountedMenus = []; // 할인된 이슈들을 저장할 리스트


  void initState() {
    super.initState();
    loadMyStores();
  }

  MystoreMenuService service = MystoreMenuService();

  void loadMyStores() async {
    // debugPrint('내점포 상세조회 - 발행소콘 목록!');
    // Map<String, dynamic>? infos = await  viewModel.storeDetailInfos(widget.storeId);
     var  infos = await service.getStoreDetailInfos(widget.storeId);
    print('njnj4444444444444njnjnjnjnjnjnjnjn');
    // print(infos.runtimeType);  //_Map<String, dynamic>
    // print('아오 ${infos}');
    print('아오 ${infos['issues']}');

    // 가게 정보
    var stores = infos['stores'];

    // 전체 상품 목록
    var issues = infos['issues'];
    // 할인 상품 목록
    var discountedIssues = issues.where((issue) => issue['is_discounted'] == true).toList();
    print('njnjnj444444444444444444njnjnjnjnjnjnjn');
    setState(() {
      storeInfos = issues;
      discountedMenus = discountedIssues;
    });
  }

  @override
  Widget build(BuildContext context) {
    // int storeId = int.parse(widget.pathParameter);
    bool isOwner = false;

    return Scaffold(
      backgroundColor: AppColors.WHITE,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // StoreTopCard(storeId: widget.storeId, isOwner: isOwner),
            SizedBox( height: 25.0,),
            Text('  할인 소콘', style: TextStyle(fontSize: FontSizes.MEDIUM, fontWeight: FontWeight.bold,) ,),
            SizedBox( height: 10.0,),
            Container(
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: saleMenuList.length,
                padding: EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 1 개의 행에 보여줄 item 개수
                  childAspectRatio: 1 / 1.2, // item 의 가로 세로의 비율
                  mainAxisSpacing: 7, // 수평 Padding
                  crossAxisSpacing: 7, // 수직 Padding
                ),
                itemBuilder: (BuildContext context, index) {
                  final saleMenu = discountedMenus[index];
                  return StoreSoconLists(
                    storeId: widget.storeId,
                    id: saleMenu['id'],
                    is_main: saleMenu['is_main'],
                    name: saleMenu['name'],
                    price: saleMenu['price'],
                    image: saleMenu['image'],
                    issued_quantity: saleMenu['issued_quantity'],
                    left_quantity: saleMenu['left_quantity'],
                    is_discounted: saleMenu['is_discounted'],
                    discounted_price: saleMenu['discounted_price'],
                    createdAt: saleMenu['createdAt'],
                  );
                },
              ),
            ),

            // 전체 소콘
            SizedBox( height: 25.0,),
            Text('  전체 소콘', style: TextStyle(fontSize: FontSizes.MEDIUM, fontWeight: FontWeight.bold,) ,),
            SizedBox( height: 10.0,),
            Container(
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: storeInfos.length,
                padding: EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 1 개의 행에 보여줄 item 개수
                  childAspectRatio: 1 / 1.2, // item 의 가로 세로의 비율
                  mainAxisSpacing: 7, // 수평 Padding
                  crossAxisSpacing: 7, // 수직 Padding
                ),
                itemBuilder: (BuildContext context, index) {
                  final saleMenu = storeInfos[index];
                  return StoreSoconLists(
                    storeId: widget.storeId,
                    id: saleMenu['id'],
                    is_main: saleMenu['is_main'],
                    name: saleMenu['name'],
                    price: saleMenu['price'],
                    image: saleMenu['image'],
                    issued_quantity: saleMenu['issued_quantity'],
                    left_quantity: saleMenu['left_quantity'],
                    is_discounted: saleMenu['is_discounted'],
                    discounted_price: saleMenu['discounted_price'],
                    createdAt: saleMenu['createdAt'],
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}

