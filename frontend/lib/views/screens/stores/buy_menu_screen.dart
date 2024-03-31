import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:socon/models/product_detail_model.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/icons.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/bottom_sheet.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/payments/buy_socon_payment.dart';

import '../../../viewmodels/payment_verification_view_model.dart';



// 가게 -> 상품 상세보기
class BuyMenuDetailScreen extends StatefulWidget {
  final String storeId;
  final String menuId;
  var data = '';


  BuyMenuDetailScreen(this.storeId, this.menuId, {super.key});

  @override
  State<BuyMenuDetailScreen> createState() => _BuyMenuDetailScreenState();
}

class _BuyMenuDetailScreenState extends State<BuyMenuDetailScreen> {
  @override

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
    // final
    final Size _size = MediaQuery.of(context).size;
    var count = 1;
    var total_price = count * menuDetail[0].price;
    

    return FutureBuilder(
        future: Provider.of<PaymentVerificationViewModel>(context, listen: false).getMenuDetail(widget.storeId, widget.menuId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('오류가 발생했습니다.'),);
            }
            return Consumer<PaymentVerificationViewModel>(
              builder: (context, viewModel, child) {
                final productDetailModel = viewModel.productDetailModel;
                return SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                            child:SingleChildScrollView(
                              child: Container(
                                color: AppColors.WHITE,
                                child: Stack(
                                  children: [
                                    Container(
                                      child: Image.network(menuDetail[0].image ?? '',
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
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: (){
                                            if(count > 0){
                                              count -= 1;
                                            }
                                          },
                                          child: Icon(Icons.remove, color: Colors.white, ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            onPressed: (){
                                              if(count > 0){
                                                count -= 1;
                                              }
                                            },
                                            icon: Icon(Icons.remove, color: Colors.white, ),
                                          ),
                                        ),

                                        SizedBox(width: 10),
                                        Text(count.toString()),
                                        SizedBox(width: 10),
                                        // '+' 아이콘 버튼
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              count += 1;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all( 0),
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
                                    Row(children: [Text('총 $total_price원')],),
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
                                    try {
                                      var orderData = {
                                        "itemName": productDetailModel.name,
                                        "price": productDetailModel.price,
                                        "quantity": 1,
                                        "issueId": productDetailModel.id,
                                      };

                                      await viewModel.sendPaymentRequest(orderData);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Payment(),
                                            settings: RouteSettings(arguments: {
                                              'orderUid': viewModel.orderUid,
                                              'issueId': 1,
                                              'name': "소금빵",
                                              'amount': 100,
                                              'buyerName': '김싸피'
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
                      ],
                    )
                );
              },
            );
          } else {
            // 로딩중 페이지
            return Center(child: CircularProgressIndicator(),);
          }
        }
     );
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
              Text(menuDetail[0].name,
              style: TextStyle(fontSize: FontSizes.XLARGE, fontWeight: FontWeight.bold),),
              Text(menuDetail[0].summary ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
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
                    image: NetworkImage(menuDetail[0].image ?? ''), // 이미지 URL
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

              Text('${menuDetail[0].price.toString()}원',
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
              Text(menuDetail[0].description ?? '',
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
                  '떠나는 길에 니가 내게 말했지 너는 바라는 게 너무나 많아 잠깐이라도 널 안 바라보면 머리에 불이 나버린다니까 나는 흐르려는 눈물을 참고 하려던 얘길 어렵게 누르고 그래 미안해라는 한 마디로 너랑 나눈 날들 마무리했었지 달디달고 달디달고 달디단 밤양갱 밤양갱 내가 먹고 싶었던 건 달디단 밤양갱 밤양갱이야 떠나는 길에 니가 내게 말했지 아냐 내가 늘 바란 건 하나야 한 개뿐이야 달디단 밤양갱 달디달고 달디달고 달디단 밤양갱 밤양갱 내가 먹고 싶었던 건 달디단 밤양갱 밤양갱이야 상다리가 부러지고 둘이서 먹다 하나가 쓰러져버려도 나라는 사람을 몰랐던 넌 떠나가다가 돌아서서 말했지',
                style: TextStyle(fontSize: FontSizes.XXXSMALL),),
            ],
          ),
        ),
      ],
    );
  }
}

//
// final PaymentVerificationViewModel _paymentVerificationViewModel = PaymentVerificationViewModel();
// _paymentVerificationViewModel.sendPaymentRequest({
//   ""
// })