import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/utils/icons.dart';
import 'package:socon/views/atoms/tab.dart';
import 'package:socon/views/atoms/tag_icon.dart';
import 'package:socon/views/modules/store_menu_management.dart';
import 'package:socon/views/modules/store_rigister_menu_lists.dart';

class StoreDetailPage extends StatelessWidget {
  final int storeId;

  const StoreDetailPage({super.key, required this.storeId, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                    child: Image.network(
                        'https://cataas.com/cat',
                        fit: BoxFit.cover,
                        height: 160,
                        width: ResponsiveUtils.getWidthPercent(context, 100)
                    ),
                  ),
                SizedBox(height: 170, ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: TabBarScreen(
                        marginTop: 0,
                        contents: {
                          '메뉴 관리': MenuManagement(storeId: storeId),
                          '발행 소콘': RegisteredMenu(),
                        }
                      ),
                  ),
                ),
              ],
            ),
            // 매장정보 카드
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: (){Navigator.pop(context);},
                      icon: Icon(
                      AppIcons.LEADING, // 클래스명.변수명
                      color: AppColors.WHITE,
                      size: 36.0, // 사이즈 설정
                      )
                  ),
                  IconButton(
                      onPressed: (){},
                      icon: Icon(
                        AppIcons.INFO, // 클래스명.변수명
                        color: AppColors.WHITE,
                        size: 36.0, // 사이즈 설정
                      )
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                top: 120,
                right: 16.0,
                left: 16.0,
              ),
              child: Container(
                height: 200.0,
                width: ResponsiveUtils.getWidthPercent(context, 100),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1, // 그림자 범위
                        blurRadius: 7, // 그림자 흐림 정도
                        offset: Offset(0, 3), // 그림자 위치 조정
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20), // 모서리 곡률을 10으로 설정
                  ),
                  // elevation: 4.0,   // Card 일때
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('오소유',
                            style: TextStyle(fontSize: FontSizes.XLARGE, fontWeight: FontWeight.bold),),
                          TagIcon(buttonText: '카페', buttonColor: Colors.brown, buttonTextColor: AppColors.WHITE, width: 45,)
                        ],
                      ),
                      Text('광주 광산구 장덕로 40번길 13-11층',
                          style: TextStyle(color: AppColors.GRAY500)),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child:  Text("오소유는 제빵명인과 디자이너의 협업으로 이루어진 베이커리,디저트 카페 입니다:) 매일 만드는 맛있는 빵과 커피 드시러 놀러오세요!",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,)
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            AppIcons.EDIT, // 클래스명.변수명
                            color: AppColors.BLACK,
                            size: 15.0, // 사이즈 설정
                            // onPressed: (){},
                          ),
                          TextButton(onPressed: (){},
                              child: Text('매장 정보 수정',
                                style: TextStyle(color: AppColors.BLACK, fontSize: FontSizes.XXXSMALL),))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: null,
    );
  }
}




