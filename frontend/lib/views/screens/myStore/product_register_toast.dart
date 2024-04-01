import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';
import 'package:flutter/material.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/icons.dart';
import 'package:socon/views/atoms/buttons.dart';
import 'package:socon/views/modules/store_detail_top_card.dart';


class RegisterToastMsg extends StatelessWidget {
  final storeId;
  const RegisterToastMsg({super.key, required this.storeId});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(height: 200,),
        Column(
          mainAxisAlignment: MainAxisAlignment.center, // 이 부분도 중앙 정렬
          children: [
            FluentUiEmojiIcon(
              fl: AppIcons.PARTY, // 클래스명.변수명
              w: 50,
              h: 50,
            ),
            Text('메뉴 등록 완료!',
              style: TextStyle(fontSize: FontSizes.XXLARGE, fontWeight: FontWeight.bold),),
            Text('점포 관리로 이동 후',
              style: TextStyle(fontSize: FontSizes.SMALL),),
            Text('소콘을 발행하실 수 있습니다',
              style: TextStyle(fontSize: FontSizes.SMALL),),
          ],
        ),
        Spacer(), // 중간 공간을 채움
        BasicButton(
            text: '다음',
            color: 'yellow',
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StoreDetailTopCard(storeId: storeId, isOwner: true,)),
              )
            }
          ),
        SizedBox(height: 10,),
      ],
    );
  }
}
