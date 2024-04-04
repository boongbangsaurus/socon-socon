import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:socon/models/product_detail_model.dart';
import 'package:socon/services/payment_service.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/icons.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/bottom_sheet.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/payments/buy_socon_payment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 처리를 위한 패키지
import 'package:shared_preferences/shared_preferences.dart';
import '../../../viewmodels/payment_verification_view_model.dart';




  final List<ProductDetailModel> menuDetail = [
    ProductDetailModel.fromJson({
      "id": 0, // 상품 id
      "name": "소금빵flfklgf",
      "image": "https://cataas.com/cat",
      "price": 300, // 상품 가격
      "summary": "갓 구워낸 따끈따끈 소금빵",
      "description":
          "부드럽고 쫄깃한 빵 속에 소금의 향기가 감도는 특별한 디저트, 우리 가게의 소금빵을 만나보세요! 달콤한 단맛과 짭짤한 소금의 조화가 입안에서 만나는 특별한 맛을 경험할 수 있습니다."
    }),
    // ProductDetailModel.fromJson({
    //   "id": 1, // 상품 id
    //   "name": "감자",
    //   "imageUrl": "https://cataas.com/cat",
    //   "price": 500, // 상품 가격
    //   "summary": "한줄 설명",
    //   "description": "상세 설명"
    //
    // }),
  ];



// 가게 -> 상품 상세보기
class BuyMenuDetailScreen extends StatefulWidget {
  // final String storeId;
  // final String menuId;
  final int storeId;
  final int menuId;

  var data = '';


  BuyMenuDetailScreen(this.storeId, this.menuId, {super.key});

  @override
  State<BuyMenuDetailScreen> createState() => _BuyMenuDetailScreenState();
}

class _BuyMenuDetailScreenState extends State<BuyMenuDetailScreen> {

  Map<String, dynamic> myMenu = {};

  @override
  void initState() {
    super.initState();
    loadMyStores();
  }

  void loadMyStores() async {
    debugPrint('내 점포리스트 요청중!');
    PaymentService service = PaymentService();
    var menus = await service.getMenuDetail(widget.storeId, widget.menuId);
    print('pppppppppppppppppp');
    print('pppppppppppppppppp');
    setState(() {
      myMenu = menus;
    print(myMenu);
    });
  }


  @override

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


  int count = 1;

  @override
  Widget build(BuildContext context) {
    // final
    final Size _size = MediaQuery.of(context).size;
    var total_price = count * myMenu['price'];

    return
      SafeArea(
          child: Column(
            children: [
              Expanded(
                  child:SingleChildScrollView(
                    child: Container(
                      color: AppColors.WHITE,
                      child: Stack(
                        children: [
                          Container(
                            child: Image.network(myMenu['store_image'] ?? '',
                                fit: BoxFit.cover,
                                height: ResponsiveUtils.getHeightWithPixels(context, 160),
                                width: ResponsiveUtils.getWidthPercent(context, 100)),
                          ),
                          shortStoreInfoWithBar(context),
                          Container(
                            height: _size.height,
                          ),
                        ],
                      ),
                    ),
                  )
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
                  children: [

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // '+' 아이콘 버튼
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (count > 1 ){
                                      count--;
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),

                              SizedBox(width: 10),
                              Text('$count', style: TextStyle(fontSize: 20),),
                              SizedBox(width: 10),

                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    count++;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(children: [Text('총 $total_price원', style: TextStyle(fontSize: 20),)],),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    // 결제 상세 페이지 이동
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: BasicButton(
                        onPressed: () async {
                          var orderUid = await savePayment(myMenu['name'], myMenu['price'], count, widget.menuId);
                          print(orderUid.runtimeType);
                          print(';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');

                          // await validatePayment('imp01516875', orderUid);
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Payment(),
                                  settings: RouteSettings(arguments: {
                                    'orderUid': orderUid,
                                    'issueId': widget.menuId,
                                    'name': myMenu['name'],
                                    'amount': myMenu['price'] * count,
                                    'buyerName': '김온유'
                                  }
                                  )
                              ),
                            );

                        },
                        text: '구매하기',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
      );
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
                  Navigator.of(context).pop();
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
              Text(myMenu['name'],
              style: TextStyle(fontSize: FontSizes.XXLARGE, fontWeight: FontWeight.bold),),

              Text(myMenu['summary'],
              style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              // Column(
              //   children: [
              //     TagIcon.NEW(),
              //     TagIcon.SALE(),
              //   ],
              // ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // 모서리의 곡률을 20으로 설정
                  image: DecorationImage(
                    image: NetworkImage(myMenu['item_image']), // 이미지 URL
                    fit: BoxFit.cover, // 이미지를 컨테이너에 맞춤
                  ),
                ),
                height: ResponsiveUtils.getHeightWithPixels(context, 160),
                // 높이 설정
                width: ResponsiveUtils.getWidthPercent(
                    context, 75), // 너비를 100%로 설정
              ),

              // 할인/비할인 경우 가격 return
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     if (is_discounted == true) ...[ // 할인된 경우
              //       Text('($discountPercent%)', style: TextStyle(fontSize: 11, color: Colors.red), ),
              //       Text('$discounted_price원', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
              //       Text('$price원', style: TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough ,decorationColor: Colors.red, decorationThickness: 2.0, fontWeight: FontWeight.bold)),
              //     ] else ...[ // 할인되지 않은 경우
              //       Text('$price원', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
              //     ]
              //   ],
              // ),
              SizedBox(height: 10,),

              Text('${myMenu['price']}원',
              style: TextStyle(fontSize: FontSizes.XXXLARGE, fontWeight: FontWeight.bold, color: AppColors.ERROR500),),
            ],
          ),
        ),
        Container(
          width: ResponsiveUtils.getWidthWithPixels(context, 330),
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 20),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('상세설명',
              style: TextStyle(fontSize: FontSizes.SMALL),),
              SizedBox(height: 10,),
              Text(myMenu['description'] ?? '',
                style: TextStyle(fontSize: FontSizes.XXSMALL),),
            ],
          ),
        ),
        Container(
          width: ResponsiveUtils.getWidthWithPixels(context, 330),
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 20),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('유의사항',
                style: TextStyle(fontSize: FontSizes.SMALL),),
              SizedBox(height: 10,),
              Text(
                "본 상품은 예시 이미지로써 실제 상품과 다를 수 있습니다. \n 매장 상황에 따라 해당 상품 이용이 제한 되거나 동일 상품으로 교환이 불가능 할 수 있습니다. \n 해당 상품 가격보다 저렴한 상품으로 교환하여 발생하는 차액은 환급이 불가하며 해당 상품 가격 이상의 상품으로 교환하는 경우 추가 결제 후 교환이 가능합니다. ",
                style: TextStyle(fontSize: FontSizes.XXXSMALL),),
            ],
          ),
        ),
      ],
    );
  }
}


// 기프티콘 주문저장 -> orderUid 발급
Future<String> savePayment(String itemName, int price, int quantity, int issueId) async {
  final String baseUrl = 'http://j10c207.p.ssafy.io:8000'; // 통신 url

  final Uri url = Uri.parse('$baseUrl/api/v1/orders');
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');

  final response = await http.post(
    url,
    headers: <String, String>{
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'itemName': itemName, // 아임포트 결제 고유 ID
      'price': price, // 아임포트 결제 고유 ID
      'quantity': quantity, // 아임포트 결제 고유 ID
      'issueId': issueId, // 주문 고유 ID
    }),
  );
  debugPrint('기프티콘 주문저장: ${response.statusCode}');

  if (response.statusCode == 200) {
    // 서버로부터 정상적인 응답을 받았을 때의 처리
    debugPrint('기프티콘 주문저장 결제 검증 성공: ${response.body}');
    debugPrint('기프티콘 주문저장 결제 검증 성공: ${response.headers}');
    final String body = utf8.decode(response.bodyBytes);
    final decodedBody = jsonDecode(body);
    // final String dataBody = decodedBody['data_body'];
    print('pppppppppppppppppppppp');
    print(decodedBody['data_body']);
    print('pppppppppppppppppppppp');
    return decodedBody['data_body']['orderUid'];
  } else {
    // 서버로부터 오류 응답을 받았을 때의 처리
    debugPrint('기프티콘 주문저장 결제 검증 실패: ${response.body}');
    // Navigator를 사용하여 결제실패 페이지로 이동하거나, 오류 메시지 표시 등의 로직 추가
    return '';
  }
}




// 주문 결제 검증 요청
Future<void> validatePayment(String impUid, String orderUid) async {
  final String baseUrl = 'http://j10c207.p.ssafy.io:8000'; // 통신 url

  final Uri url = Uri.parse('$baseUrl/api/v1/payments/validate');
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');

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