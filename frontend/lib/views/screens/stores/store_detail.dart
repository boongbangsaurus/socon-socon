import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socon/models/socon_card.dart';
import 'package:socon/services/payment_service.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/modules/mystore_menu_card.dart';
import 'package:socon/views/modules/socon_storesocon.dart';
import 'package:socon/views/modules/store_detail_top_card.dart';
import 'package:socon/views/payments/buy_socon_payment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 처리를 위한 패키지
import 'package:shared_preferences/shared_preferences.dart';


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
            Text('할인 소콘', style: TextStyle(fontSize: FontSizes.MEDIUM, fontWeight: FontWeight.bold,) ,),
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
                  return StoreSoconLists(
                    storeId: storeId,
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: BasicButton(
                onPressed: () async {

                  try {
                    // 결제 검증 호출

                    // var orderData = {
                    //   "itemName": '멸치꼬마김밥',
                    //   "price": 300,
                    //   "quantity": 1,
                    //   "issueId": 1,
                    // };

                    // var paymentService = PaymentService();
                    // var orderUid = await paymentService.sendPaymentRequest(orderData);

                    // var impUid = 'imp01516875';
                    // var orderUid = 'd2ff7305-0e1d-4852-a3ae-3c94e49f95ed';
                    // await validatePayment(impUid, orderUid);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Payment(),
                          settings: RouteSettings(arguments: {
                            'orderUid': '26e28cc1-d403-487c-b36c-56b905dc1056',
                            'issueId': 1,
                            'name': "소고기버섯비빔밥",
                            'amount': 300,
                            'buyerName': '김온유'
                          }
                        )
                      ),
                    );




                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => PaymentPage(orderUid: viewModel.orderUid)),
                    //   );
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("결제 실패: $error")));
                  }

                },
                text: '구매하기',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// 결제 검증 요청 (콜백함수)
Future<void> validatePayment(String impUid, String orderUid) async {
  // final String baseUrl = 'http://j10c207.p.ssafy.io:8000'; // 통신 url
  final String baseUrl = 'https://f7a9-121-178-98-30.ngrok-free.app';

  final Uri url = Uri.parse('$baseUrl/api/v1/payments/validate');
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');

  print('$accessToken >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'impUid': impUid, // 아임포트 결제 고유 ID
        'orderUid': orderUid, // 주문 고유 ID
      }),
    );
    debugPrint('결제 ~~: ${response.statusCode}');

    if (response.statusCode == 200) {
      // 서버로부터 정상적인 응답을 받았을 때의 처리
      debugPrint('결제 검증 성공: ${response.body}');
      debugPrint('결제 검증 성공: ${response.headers}');
      // Navigator를 사용하여 결제완료 페이지로 이동하거나, 상태 업데이트 등의 로직 추가
    } else {
      // 서버로부터 오류 응답을 받았을 때의 처리
      debugPrint('결제 검증 실패: ${response.body}');
      // Navigator를 사용하여 결제실패 페이지로 이동하거나, 오류 메시지 표시 등의 로직 추가
    }
  } catch (e) {
    debugPrint('결제 검증 중 예외 발생: $e');
    // 예외 발생 시 처리 로직 추가
  }
}