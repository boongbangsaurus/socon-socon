import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 처리를 위한 패키지

/* 아임포트 결제 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_payment.dart';
/* 아임포트 결제 데이터 모델을 불러옵니다. */
import 'package:iamport_flutter/model/payment_data.dart';

class Payment extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    // debugPrint(arg.toString());
    var name = arg?['name'].toString();
    var amount = arg?['amount'].toInt();
    var buyerName = arg?['buyerName'].toString();
    var issueId = arg?['issueId'].toInt();

    return IamportPayment(
      appBar: new AppBar(
        title: new Text('아임포트 결제'),
      ),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('assets/images/iamport-logo.png'),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),

              Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      // userCode: 'iamport',
      userCode: 'imp01516875',
      /* [필수입력] 결제 데이터 */
      data: PaymentData(
          pg: 'html5_inicis',                                          // PG사
          payMethod: 'card',                                           // 결제수단
          name: name,                                  // 주문명
          merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호 Required
          amount: amount,                                               // 결제금액 Required
          buyerName: buyerName,                                           // 구매자 이름 Required
          buyerTel: '01012345678',                                     // 구매자 연락처
          buyerEmail: 'example@naver.com',                             // 구매자 이메일
          buyerAddr: '서울시 강남구 신사동 661-16',                         // 구매자 주소
          buyerPostcode: '06018',                                      // 구매자 우편번호
          appScheme: 'example',                                        // 앱 URL scheme Required
          cardQuota : [2,3]                                            //결제창 UI 내 할부개월수 제한
      ),





      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) async{
        // 1. 회원이 요청한 데이터 == 실제 상품 데이터 확인
        //  a. 맞으면 백에게 결제 요청? 보내고 결제완료 페이지
        //  b. 아니면 결제실패 페이지


        var response = await http.post(
          Uri.parse('/api/v1/issues/{issue_id}/order'),
          body: json.encode({
            'itemName': name, // 상품명
            'amount': amount, // 결제 금액
            'name': buyerName, //
            'issueId': issueId,
          }),
        );
        debugPrint(response as String?);

        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => Payment())
        //
        // );
      },
    );
  }
}