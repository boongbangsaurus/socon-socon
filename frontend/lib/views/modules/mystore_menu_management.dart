import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/models/mystore_detail_menu.dart';
import 'package:socon/models/socon_card.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/modules/add_menu_card.dart';
import 'package:socon/views/modules/socon_storesocon.dart';
import 'package:socon/views/modules/mystore_menu_card.dart';
import 'package:socon/views/screens/myStore/store_product_register.dart';

class MenuManagement extends StatelessWidget {
  final int storeId;
  final bool isOwner = false;

  MenuManagement({
    super.key,
    required this.storeId,
  });

  final List<Menu> storeMenuList = [
    Menu.fromJson({
      "id": 0, // 상품 id
      "name": "소금빵",
      "imageUrl": "https://cataas.com/cat",
      "price": 3000 // 상품 가격
    }),
    Menu.fromJson({
      "id": 1, // 상품 id
      "name": "감자",
      "imageUrl": "https://cataas.com/cat",
      "price": 3500 // 상품 가격
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.0,),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            // child 위젯의 크기를 정해주지 않은 경우 true로 지정해야됨
            itemCount: storeMenuList.length + 1,
            //item 개수
            padding: EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
              childAspectRatio: 1 / 1.2, //item 의 가로 세로의 비율
              mainAxisSpacing: 7, //수평 Padding
              crossAxisSpacing: 7, //수직 Padding
            ),
            itemBuilder: (BuildContext context, index) {
              if(index == 0){
                return AddMenuCard(storeId : storeId,);
              }else{
                final storeMenu = storeMenuList[index -1];
                return StoreMenuCard(
                  storeId : storeId,
                  id : storeMenu.id,
                  name : storeMenu.name,
                  price: storeMenu.price,
                  image: storeMenu.imageUrl,
                  // soconName: socon.soconName!,
                  // price: socon.price!,
                  // imageUrl: socon.imageUrl ?? '',
                );
              }

            },
          ),
        ),
      ],
    );
  }
}


// {
// "id": 0, // 상품 id
// "name": "상품 이름",
// "image": "https://cataas.com/cat",
// "price": 3000 // 상품 가격
// },


// 메뉴 정보
// {
// "id": 0, // issue id
// "is_main": true, // 대표 상품 여부
// "name": "발행 상품 이름",
// "image": "https://cataas.com/cat",
// "issued_quantity": 3, // 현재 발행량 (구매된 갯수)
// "left_quantity": 4, // 남은 갯수
// "is_discounted": true, // 할인 여부
// "price": 3000, // 정가(할인 전 가격)
// "discounted_price": 2500, // 할인 적용된 가격
// "created_at": "YYYY-MM-DD" // 발행 정보 등록된 날짜
// },