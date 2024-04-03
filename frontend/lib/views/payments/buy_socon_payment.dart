import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


/* 아임포트 결제 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_payment.dart';
/* 아임포트 결제 데이터 모델을 불러옵니다. */
import 'package:iamport_flutter/model/payment_data.dart';


class Payment extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    var orderUid = arg!['orderUid'].toString();

    debugPrint('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    debugPrint(arg.toString());
    debugPrint('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    var name = arg['name'].toString();
    var amount = arg?['amount'].toInt();
    var buyerName = arg?['buyerName'].toString();
    var issueId = arg?['issueId'].toInt();
    var test = 'mid_${DateTime.now().millisecondsSinceEpoch}';

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
          merchantUid: orderUid, // 주문번호 Required
          amount: amount,                                               // 결제금액 Required
          buyerName: buyerName,                                           // 구매자 이름 Required
          buyerTel: '01023445664',                                     // 구매자 연락처
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
        debugPrint('결제 후 콜백 함수: $result');
        debugPrint('결제 후 콜백 함수 imppppp: ${result['imp_uid']}');
        debugPrint('결제후 콜백 함수11111111111111111111111');
        String? impUid = 'imp01516875'; // 아임포트에서 제공하는 결제 고유 ID
        debugPrint('impUid ${impUid}2222222222222222222');
        debugPrint('orderUid ${orderUid}333333333333333333333333');


        GoRouter.of(context).go("/");
        // 결제 검증 함수 호출
        // await validatePayment(result['imp_uid'].toString(), orderUid);


        // Navigator.of(context).push(
        //   MaterialPageRoute(builder: (context) => Payment())
        //
        // );
      },
    );
  }

}

// 결제 검증 요청 (콜백함수)
// Future<void> validatePayment(String impUid, String orderUid) async {
//   final String baseUrl = 'http://j10c207.p.ssafy.io:8000'; // 통신 url
//   // final String baseUrl = 'https://f7a9-121-178-98-30.ngrok-free.app';
//   // 통신 url
//   final Uri url = Uri.parse('$baseUrl/api/v1/payments/validate');
//   final prefs = await SharedPreferences.getInstance();
//   final accessToken = prefs.getString('accessToken');
//
//   print('$accessToken >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
//   try {
//     final response = await http.post(
//       url,
//       headers: <String, String>{
//         'Authorization': 'Bearer $accessToken',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'impUid': impUid, // 아임포트 결제 고유 ID
//         'orderUid': orderUid, // 주문 고유 ID
//       }),
//     );
//     debugPrint('결제 ~~: ${response.statusCode}');
//
//     if (response.statusCode == 200) {
//       // 서버로부터 정상적인 응답을 받았을 때의 처리
//       debugPrint('결제 검증 성공: ${response.body}');
//       debugPrint('결제 검증 성공: ${response.headers}');
//       // Navigator를 사용하여 결제완료 페이지로 이동하거나, 상태 업데이트 등의 로직 추가
//     } else {
//       // 서버로부터 오류 응답을 받았을 때의 처리
//       debugPrint('결제 검증 실패: ${response.body}');
//       // Navigator를 사용하여 결제실패 페이지로 이동하거나, 오류 메시지 표시 등의 로직 추가
//     }
//   } catch (e) {
//     debugPrint('결제 검증 중 예외 발생: $e');
//     // 예외 발생 시 처리 로직 추가
//   }
// }