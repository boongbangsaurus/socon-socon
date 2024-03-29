import 'package:flutter/material.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/qr_code.dart';
import 'package:socon/views/modules/app_bar.dart';
import 'package:socon/views/modules/socon_coupon.dart';

class SoconBookDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWithArrow(title: '소콘북'),
      body: Container(
        color: AppColors.GRAY100,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SoconCoupon(),
              SizedBox(height: 25),
              DetailedSoconInfo(context),
              SizedBox(height: 20),
              WarningSoconInfo(context),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget DetailedSoconInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.WHITE,
      ),
      width: ResponsiveUtils.getWidthWithPixels(context, 320),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "상세설명",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: ResponsiveUtils.calculateResponsiveFontSize(context, FontSizes.XSMALL)),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
              "부드럽고 쫄깃한 빵 속에 소금의 향기가 감도는 특별한 디저트, 우리 가게의 소금빵을 만나보세요! 달콤한 단맛과 짭짤한 소금의 조화가 입안에서 만나는 특별한 맛을 경험할 수 있습니다. 우리 가게의 소금빵은 신선한 재료와 정성스러운 손길로 만들어집니다. 바삭한 표면과 부드러운 내용이 함께 어우러진 이 빵은 아침 식사나 오후 간식으로 최적의 선택입니다. 뜨거운 커피나 차와 함께 즐겨보세요!",
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize: ResponsiveUtils.calculateResponsiveFontSize(context, FontSizes.XXXSMALL)),
              textAlign: TextAlign.left)
        ],
      ),
    );
  }

  Widget WarningSoconInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.WHITE,
      ),
      width: ResponsiveUtils.getWidthWithPixels(context, 320),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("유의사항",
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: ResponsiveUtils.calculateResponsiveFontSize(context,  FontSizes.XSMALL))),
          SizedBox(
            height: 15.0,
          ),
          Text(
              "떠나는 길에 니가 내게 말했지 '너는 바라는 게 너무나 많아 잠깐이라도 널 안 바라보면 머리에 불이 나버린다니까' 나는 흐르려는 눈물을 참고 하려던 얘길 어렵게 누르고 '그래 미안해'라는 한 마디로 너랑 나눈 날들 마무리했었지 달디달고 달디달고 달디단 밤양갱 밤양갱 내가 먹고 싶었던 건 달디단 밤양갱 밤양갱이야 떠나는 길에 니가 내게 말했지 '너는 바라는 게 너무나 많아' 아냐 내가 늘 바란 건 하나야 한 개뿐이야 달디단 밤양갱 달디달고 달디달고 달디단 밤양갱 밤양갱 내가 먹고 싶었던 건 달디단 밤양갱 밤양갱이야 상다리가 부러지고 둘이서 먹다 하나가 쓰러져버려도 나라는 사람을 몰랐던 넌 떠나가다가 돌아서서 말했지 '너는 바라는 게 너무나 많아 아냐 내가 늘 바란 건 하나야 한 개뿐이야 달디단 밤양갱",
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize:ResponsiveUtils.calculateResponsiveFontSize(context,  FontSizes.XXXSMALL)))
        ],
      ),
    );
  }
}


