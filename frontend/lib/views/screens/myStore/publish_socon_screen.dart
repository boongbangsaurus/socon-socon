import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socon/views/atoms/icon_loader.dart';
import 'package:socon/views/modules/cards/detail_info_card.dart';
import 'package:socon/views/modules/menu_detail_top_card.dart';

import '../../../models/menu.dart';
import '../../../utils/colors.dart';
import '../../../utils/fontSizes.dart';
import '../../../utils/responsive_utils.dart';
import '../../atoms/bottom_sheet.dart';
import '../../atoms/buttons.dart';
import '../../modules/plus_minus_btn.dart';

// {
// "id" : 1, // 상품 id
// "name" : "소금빵",
// "image" : "이미지 url",
// "price" : 3000,
// "summary" : "한줄설명",
// "description" : "상세 설명"
// }

class PublishSoconScreen extends StatefulWidget {
  final String? menuId;
  final String? storeId;

  const PublishSoconScreen(this.menuId, this.storeId, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PublishSoconScreenState();
}

class _PublishSoconScreenState extends State<PublishSoconScreen> {
  late Future<Menu> _menu;
  final String description =
      "부드럽고 쫄깃한 빵 속에 소금의 향기가 감도는 특별한 디저트, 우리 가게의 소금빵을 만나보세요! 달콤한 단맛과 짭짤한 소금의 조화가 입안에서 만나는 특별한 맛을 경험할 수 있습니다. 우리 가게의 소금빵은 신선한 재료와 정성스러운 손길로 만들어집니다. 바삭한 표면과 부드러운 내용이 함께 어우러진 이 빵은 아침 식사나 오후 간식으로 최적의 선택입니다. 뜨거운 커피나 차와 함께 즐겨보세요!";
  final String caution =
      "떠나는 길에 니가 내게 말했지 '너는 바라는 게 너무나 많아 잠깐이라도 널 안 바라보면 머리에 불이 나버린다니까' 나는 흐르려는 눈물을 참고 하려던 얘길 어렵게 누르고 '그래 미안해'라는 한 마디로 너랑 나눈 날들 마무리했었지 달디달고 달디달고 달디단 밤양갱 밤양갱 내가 먹고 싶었던 건 달디단 밤양갱 밤양갱이야 떠나는 길에 니가 내게 말했지 '너는 바라는 게 너무나 많아' 아냐 내가 늘 바란 건 하나야 한 개뿐이야 달디단 밤양갱 달디달고 달디달고 달디단 밤양갱 밤양갱 내가 먹고 싶었던 건 달디단 밤양갱 밤양갱이야 상다리가 부러지고 둘이서 먹다 하나가 쓰러져버려도 나라는 사람을 몰랐던 넌 떠나가다가 돌아서서 말했지 '너는 바라는 게 너무나 많아 아냐 내가 늘 바란 건 하나야 한 개뿐이야 달디단 밤양갱";

  @override
  void initState() {
    super.initState();
    // Initialize _menu with actual Menu object
    _menu = Future.delayed(
        Duration(milliseconds: 3000),
        () => Menu(
              id: 0,
              name: "소금빵",
              imageUrl: "https://cataas.com/cat",
              itemUrl:
                  "https://firebasestorage.googleapis.com/v0/b/socon-socon.appspot.com/o/images%2Fsocon%2Fsocon2.png?alt=media&token=e7736390-6c7b-4d96-97fa-02e9383ab60c",
              price: 3000,
              summary: "갓 구워낸 따끈따끈 소금빵",
              description: description,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.GRAY100,
      body: Stack(
        children: <Widget>[
          FutureBuilder<Menu>(
            future: _menu,
            builder: (BuildContext context, AsyncSnapshot<Menu> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return SingleChildScrollView(
                  // SingleChildScrollView 추가
                  child: Container(
                    width: ResponsiveUtils.getWidthPercent(context, 100),
                    // 너비를 100%로 설정
                    child: Column(
                      children: [
                        // Text("menuId ${widget.menuId}")
                        MenuDetailTopCard(menu: snapshot.data!),
                        SizedBox(height: 20),
                        DetailInfoCard(
                          contents: snapshot.data!.description,
                        ),
                        SizedBox(height: 20),
                        DetailInfoCard(
                          title: "유의사항",
                          contents: caution,
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: CustomBottomSheet(
              // maxHeight: _size.height * 0.745,
              maxHeight: ResponsiveUtils.getHeightPercent(context, 25),
              headerHeight: 60.0,
              header: Container(
                  padding: EdgeInsets.fromLTRB(40, 30, 40, 0),
                  height: 60.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "발행 개수",
                        style: TextStyle(
                          fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                            context,
                            FontSizes.SMALL,
                          ),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      PlusMinusButton(),
                    ],
                  )),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  spreadRadius: -1.0,
                  offset: Offset(0.0, 3.0),
                ),
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4.0,
                  spreadRadius: -1.0,
                  offset: Offset(0.0, 0.0),
                ),
              ],
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: [
                        BasicButton(
                          btnSize: 'fatM',
                          onPressed: () {},
                          text: '발행하기',
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        BasicButton(
                          btnSize: 'fatM',
                          color: "red",
                          onPressed: () {},
                          text: '발행 중지',
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
