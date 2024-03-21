import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'image_card.dart';
import 'tag_icon.dart';

class StoreSoconLists extends StatelessWidget {
  final String soconName;
  final bool isMain;
  final int maxQuantity;    // 설정된 최대 발행량
  final int issuedQuantity;   // 현재 발행 개수
  final int price;     // 상품가격(정가)
  final bool isDicounted;
  final int discountedPrice;    // 할인된 가격. 없을 경우 null
  final String imageUrl;

  const StoreSoconLists({
    super.key,
    required this.soconName,
    required this.isMain,
    required this.maxQuantity,
    required this.issuedQuantity,
    required this.price,
    required this.isDicounted,
    required this.discountedPrice,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width / 2;
    final remainQuantity = maxQuantity - issuedQuantity;
    final discountPercent = isDicounted ? ((price - discountedPrice) / price * 100).toStringAsFixed(0) : '0';
    return Container(
      width: screenWidth,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          color: isMain ? Colors.lightGreenAccent : Colors.white,
          borderRadius: BorderRadius.circular(10),
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
                TagIcon(buttonText: 'NEW', buttonColor: Color(0xffFBBC05), buttonTextColor: Colors.white),
                TagIcon(buttonText: 'SALE', buttonColor: Color(0xffFEF4444), buttonTextColor: Colors.white),
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
                      soconName,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        '잔여수량 $remainQuantity',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (isDicounted) ...[ // 할인된 경우
                      Text('($discountPercent%)', style: TextStyle(fontSize: 12, color: Colors.red), ),
                      Text('$discountedPrice원', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
                      Text('$price원', style: TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough, fontWeight: FontWeight.bold)),
                    ] else ...[ // 할인되지 않은 경우
                      Text('$price원', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
                    ]
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: ImageCard(
              imgUrl: imageUrl,
            ),
          ),
        ],
      ),
    );
  }
}


