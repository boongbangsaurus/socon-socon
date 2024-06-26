import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/views/screens/stores/buy_menu_screen.dart';
import 'dart:math';

import '../../utils/responsive_utils.dart';
import '../atoms/image_card.dart';
import '../atoms/tag_icon.dart';


class StoreSoconLists extends StatelessWidget {
  final int storeId;
  final int id;
  final String name;
  final bool? is_main;
  final int price;     // 상품가격(정가)
  final bool? is_discounted;
  final int? discounted_price;    // 할인된 가격. 없을 경우 null
  final String image;
  final DateTime? createdAt;
  final int? issued_quantity;    // 현재 발행량(구매된 갯수)
  final int? left_quantity;   // 남은 갯수


  const StoreSoconLists({
    super.key,
    required this.storeId,
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.is_main,
    this.is_discounted,
    this.discounted_price,
    this.createdAt,
    this.issued_quantity,
    this.left_quantity,
  });



  @override
  Widget build(BuildContext context) {
    final String discountPercent = is_discounted == true && discounted_price != null ? ((price - discounted_price!) / price * 100).toStringAsFixed(0) : '0';
    final isNew = createdAt != null ? DateTime.now().difference(createdAt!).inDays < 1 && DateTime.now().difference(createdAt!).isNegative == false : false;

    final List<String> images = ['assets/images/backgroundImg_1.JPG', 'assets/images/backgroundImg_2.png'];
    final random = Random();
    final String randomImage = images[random.nextInt(images.length)];


    return GestureDetector (
      onTap: () async {
        // 로딩 다이얼로그 표시
        showDialog(
          context: context,
          barrierDismissible: true, // 사용자가 다이얼로그 바깥을 터치하면 닫힘
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(), // 로딩 인디케이터
                    SizedBox(width: 20),
                    Text("로딩 중..."), // 로딩 텍스트
                  ],
                ),
              ),
            );
          },
        );

        // 여기서 페이지 이동을 처리합니다.
        // 예를 들어 Navigator.push를 사용하거나 다른 페이지 이동 메커니즘을 사용할 수 있습니다.
        // 이 예시에서는 Navigator.push를 사용합니다.
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BuyMenuDetailScreen(storeId, id)),
        );

        // 페이지 이동이 완료되면 로딩 다이얼로그를 닫습니다.
        // Navigator.pop(context); // 로딩 다이얼로그 닫기
      },
      child: Container(
        width: ResponsiveUtils.getWidthWithPixels(context, 154),
        height: ResponsiveUtils.getHeightWithPixels(context, 182),
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: is_main ?? false ? null : Colors.white,
            image: is_main ?? false ? DecorationImage(
              image: AssetImage(randomImage),
              fit: BoxFit.cover,
            ) : null,

            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 0,
                blurRadius: 5.0,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  isNew? TagIcon.NEW() : Text(''),
                  // isNew? TagIcon.NEW() : Text(''),
                  is_discounted == true ? TagIcon.SALE() : Text(''),

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, ),
                      ),

                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (is_discounted == true) ...[ // 할인된 경우
                        Text('($discountPercent%)', style: TextStyle(fontSize: 11, color: Colors.red), ),
                        Text('$discounted_price원', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                        Text('$price원', style: TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough ,decorationColor: Colors.red, decorationThickness: 2.0, fontWeight: FontWeight.bold)),
                      ] else ...[ // 할인되지 않은 경우
                        Text('$price원', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                      ]
                    ],
                  )
                ],
              ),
            ),
            // SizedBox(height: 5),
            Expanded(
              child: ImageCard(
                imgUrl: image,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


