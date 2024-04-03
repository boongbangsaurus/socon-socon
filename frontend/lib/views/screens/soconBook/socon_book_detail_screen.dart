// import 'package:flutter/material.dart';
// import 'package:socon/utils/colors.dart';
// import 'package:socon/utils/fontSizes.dart';
// import 'package:socon/utils/responsive_utils.dart';
// import 'package:socon/views/atoms/qr_code.dart';
// import 'package:socon/views/modules/app_bar.dart';
// import 'package:socon/views/modules/cards/detail_info_card.dart';
// import 'package:socon/views/modules/socon_coupon.dart';
//
// class SoconBookDetailScreen extends StatelessWidget {
//   final String? pathParameter;
//   final String description =
//       "부드럽고 쫄깃한 빵 속에 소금의 향기가 감도는 특별한 디저트, 우리 가게의 소금빵을 만나보세요! 달콤한 단맛과 짭짤한 소금의 조화가 입안에서 만나는 특별한 맛을 경험할 수 있습니다. 우리 가게의 소금빵은 신선한 재료와 정성스러운 손길로 만들어집니다. 바삭한 표면과 부드러운 내용이 함께 어우러진 이 빵은 아침 식사나 오후 간식으로 최적의 선택입니다. 뜨거운 커피나 차와 함께 즐겨보세요!";
//   final String caution =
//       "떠나는 길에 니가 내게 말했지 '너는 바라는 게 너무나 많아 잠깐이라도 널 안 바라보면 머리에 불이 나버린다니까' 나는 흐르려는 눈물을 참고 하려던 얘길 어렵게 누르고 '그래 미안해'라는 한 마디로 너랑 나눈 날들 마무리했었지 달디달고 달디달고 달디단 밤양갱 밤양갱 내가 먹고 싶었던 건 달디단 밤양갱 밤양갱이야 떠나는 길에 니가 내게 말했지 '너는 바라는 게 너무나 많아' 아냐 내가 늘 바란 건 하나야 한 개뿐이야 달디단 밤양갱 달디달고 달디달고 달디단 밤양갱 밤양갱 내가 먹고 싶었던 건 달디단 밤양갱 밤양갱이야 상다리가 부러지고 둘이서 먹다 하나가 쓰러져버려도 나라는 사람을 몰랐던 넌 떠나가다가 돌아서서 말했지 '너는 바라는 게 너무나 많아 아냐 내가 늘 바란 건 하나야 한 개뿐이야 달디단 밤양갱";
//
//   const SoconBookDetailScreen(this.pathParameter, {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     String soconId = pathParameter!;
//     print("soconId 가져왔니 $soconId");
//
//
//
//     return Scaffold(
//       appBar: CustomAppBarWithArrow(title: '소콘북'),
//       body: Container(
//         color: AppColors.GRAY100,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SoconCoupon(),
//               SizedBox(height: 25),
//               DetailInfoCard(contents: description),
//               SizedBox(height: 20),
//               DetailInfoCard(title: "유의사항", contents: caution),
//               SizedBox(height: 25),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/viewmodels/my_socon_view_model.dart';
import 'package:socon/views/atoms/qr_code.dart';
import 'package:socon/views/modules/app_bar.dart';
import 'package:socon/views/modules/cards/detail_info_card.dart';
import 'package:socon/views/modules/socon_coupon.dart';
import 'package:socon/views/modules/socon_mysocon.dart';

class SoconBookDetailScreen extends StatelessWidget {
  final String pathParameter;
  final String description =
      "부드럽고 쫄깃한 빵 속에 소금의 향기가 감도는 특별한 디저트, 우리 가게의 소금빵을 만나보세요! 달콤한 단맛과 짭짤한 소금의 조화가 입안에서 만나는 특별한 맛을 경험할 수 있습니다. 우리 가게의 소금빵은 신선한 재료와 정성스러운 손길로 만들어집니다. 바삭한 표면과 부드러운 내용이 함께 어우러진 이 빵은 아침 식사나 오후 간식으로 최적의 선택입니다. 뜨거운 커피나 차와 함께 즐겨보세요!";
  final String caution =
      "떠나는 길에 니가 내게 말했지 '너는 바라는 게 너무나 많아 잠깐이라도 널 안 바라보면 머리에 불이 나버린다니까' 나는 흐르려는 눈물을 참고 하려던 얘길 어렵게 누르고 '그래 미안해'라는 한 마디로 너랑 나눈 날들 마무리했었지 달디달고 달디달고 달디단 밤양갱 밤양갱 내가 먹고 싶었던 건 달디단 밤양갱 밤양갱이야 떠나는 길에 니가 내게 말했지 '너는 바라는 게 너무나 많아' 아냐 내가 늘 바란 건 하나야 한 개뿐이야 달디단 밤양갱 달디달고 달디달고 달디단 밤양갱 밤양갱 내가 먹고 싶었던 건 달디단 밤양갱 밤양갱이야 상다리가 부러지고 둘이서 먹다 하나가 쓰러져버려도 나라는 사람을 몰랐던 넌 떠나가다가 돌아서서 말했지 '너는 바라는 게 너무나 많아 아냐 내가 늘 바란 건 하나야 한 개뿐이야 달디단 밤양갱";

  SoconBookDetailScreen(this.pathParameter, {super.key});
  @override
  Widget build(BuildContext context) {
    String soconId = pathParameter!;
    print("soconId 가져왔니 $soconId");

    return Scaffold(
      appBar: CustomAppBarWithArrow(title: '소콘북'),
      body: FutureBuilder(
        future: getSoconInfo(), // API 호출을 시뮬레이션하는 함수
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 로딩 중이면 로딩 표시
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // 에러가 발생하면 에러 표시
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic>? soconInfo = snapshot.data;
            if (soconInfo != null) {
              return Container(
                color: AppColors.GRAY100,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SoconCoupon(soconInfo : soconInfo, soconId : pathParameter),
                      SizedBox(height: 25),
                      DetailInfoCard(contents: soconInfo["description"]),
                      SizedBox(height: 20),
                      DetailInfoCard(title: "유의사항", contents: caution),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              );
            }
          }
          // 에러가 없고 데이터도 없는 경우 빈 컨테이너 반환
          return Container();
        },
      ),
    );
  }

  MySoconViewModel _mySoconViewModel = MySoconViewModel();

  Future<Map<String, dynamic>?> getSoconInfo() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      if (pathParameter == null) {
        throw Exception('Path parameter is null');
      }
      Map<String, dynamic>? soconInfo = await _mySoconViewModel.getSoconInfo(pathParameter!);
      print("getSoconInfo result: $soconInfo");
      return soconInfo;
    } catch (e) {
      print("Error fetching soconInfo: $e");
      return null;
    }
  }
}
