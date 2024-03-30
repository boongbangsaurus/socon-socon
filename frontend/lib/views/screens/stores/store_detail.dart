import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socon/models/socon_card.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/modules/mystore_menu_card.dart';
import 'package:socon/views/modules/store_detail_top_card.dart';


class StoreDetailScreen extends StatelessWidget {
  final String? pathParameter;

  StoreDetailScreen( this.pathParameter, {super.key});

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


  @override
  Widget build(BuildContext context) {
    int storeId = int.parse(pathParameter!);
    bool isOwner = false;

    return Scaffold(
      backgroundColor: AppColors.WHITE,
      body: SingleChildScrollView(
        child: Column(
          children: [
            StoreDetailTopCard(storeId: storeId, isOwner: isOwner),
            SizedBox( height: 25.0,),
            Text('      할인 소콘', style: TextStyle(fontSize: FontSizes.MEDIUM, fontWeight: FontWeight.bold,) ,),
            SizedBox( height: 5.0,),
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
                  final saleMenu = saleMenuList[index];
                  return StoreMenuCard(
                    id: saleMenu.id,
                    is_main: saleMenu.is_main,
                    name: saleMenu.name,
                    price: saleMenu.price,
                    image: saleMenu.image,
                    issued_quantity: saleMenu.issued_quantity,
                    left_quantity: saleMenu.left_quantity,
                    is_discounted: saleMenu.is_discounted,
                    discounted_price: saleMenu.discounted_price,
                    createdAt: saleMenu.createdAt,
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
