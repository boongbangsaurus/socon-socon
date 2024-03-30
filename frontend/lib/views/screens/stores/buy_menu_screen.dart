import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/icons.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/bottom_sheet.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/atoms/tag_icon.dart';
import 'package:socon/views/payments/buy_socon_payment.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';


Future<Map<String, dynamic>> itemDetailData(String storeId, String itemId) async {
  final response = await http.post(
    Uri.parse('http://j10c207.p.ssafy.io:8000/api/v1/stores/$storeId/items/$itemId'),
  );
  print('$response 응답데이터ㅓㅓ');

  if (response.statusCode == 200) {
    // 서버로부터 정상적인 응답을 받았을 때
    return json.decode(response.body);
  } else {
    // 서버로부터 에러 응답을 받았을 때
    throw Exception('Failed to load item');
  }
}



// 가게 -> 상품 상세보기
class BuyMenuDetailScreen extends StatelessWidget {
  final String storeId;
  final String menuId;

  // final List<Menu> storeMenuList = [
  //   Menu.fromJson({
  //     "id": 0, // 상품 id
  //     "name": "소금빵",
  //     "imageUrl": "https://cataas.com/cat",
  //     "price": 3000 // 상품 가격
  //   }),
  //   Menu.fromJson({
  //     "id": 1, // 상품 id
  //     "name": "감자",
  //     "imageUrl": "https://cataas.com/cat",
  //     "price": 3500 // 상품 가격
  //   }),
  // ];

  BuyMenuDetailScreen(this.storeId, this.menuId, {super.key});

  final Widget _header = Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6.0, bottom: 8.0),
            width: 50.0,
            height: 6.5,
            decoration: BoxDecoration(
                color: Colors.black45, borderRadius: BorderRadius.circular(50)),
          ),
          // bottom header Title Text - nullable
          // Text("Drag the header to see bottom sheet"),
        ],
      ));


  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return SafeArea(
        child: Container(
      color: AppColors.WHITE,
      child: Stack(
        children: [
          Container(
            child: Image.network('https://cataas.com/cat',
                fit: BoxFit.cover,
                height: ResponsiveUtils.getHeightWithPixels(context, 160),
                width: ResponsiveUtils.getWidthPercent(context, 100)),
          ),
          shortStoreInfoWithBar(context),
          Container(
            height: _size.height,
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: CustomBottomSheet(
              // maxHeight: _size.height * 0.745,
              maxHeight: _size.height * 0.245,
              headerHeight: 50.0,
              header: this._header,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    spreadRadius: -1.0,
                    offset: Offset(0.0, 3.0)),
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    spreadRadius: -1.0,
                    offset: Offset(0.0, 0.0)),
              ],
              children: [ // 여기에 들어갈 위젯 넣기
                SizedBox(height: 20,),
                BasicButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Payment(),
                      settings: RouteSettings(
                          arguments: {
                            'memberId' : 1,
                            'issueId' : 1,
                            'name' :"소금빵",
                            'amount' : 10,
                            'buyerName' : '김싸피'
                          }
                        )
                      ),
                    );
                  },
                  text: '구매하기',
                ),
                
              ],
            ),
          ),
        ],
      ),
    ));
    // bottomNavigationBar: null,
  }

  Widget shortStoreInfoWithBar(BuildContext context) {
    return Column(
      children: [
        // 매장 정보에 대한 상단 바
        Container(
          margin: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  // Navigator 이동 기능 주석 처리됨
                },
                icon: Icon(
                  AppIcons.LEADING, // 아이콘
                  color: AppColors.WHITE,
                  size: ResponsiveUtils.getWidthWithPixels(
                      context, 28.0), // 아이콘 크기
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  AppIcons.INFO, // 아이콘
                  color: AppColors.WHITE,
                  size: ResponsiveUtils.getWidthWithPixels(
                      context, 24.0), // 아이콘 크기
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ResponsiveUtils.getHeightWithPixels(context, 50)),
        shortStoreInfoCard(context),
      ],
    );
  }

  Widget shortStoreInfoCard(BuildContext context) {
    return // 매장 정보 카드
        Column(
          children: [
            Container(
              width: ResponsiveUtils.getWidthWithPixels(context, 330),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(top: 10),
              // 상단 바와의 간격 추가
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('소금빵'),
                  Text('갓 구워낸 따끈따끈 소금빵'),
                  Column(
                    children: [
                      TagIcon.NEW(),
                      TagIcon.SALE(),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              width: ResponsiveUtils.getWidthWithPixels(context, 330),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(top: 10),
              // 상단 바와의 간격 추가
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('상세설명'),
                  Text('설명~~'),


                ],
              ),
            ),
          ],
    );
  }
}
