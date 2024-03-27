import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/utils/toast_utils.dart';

import '../../utils/colors.dart';
import '../../utils/fontSizes.dart';
import '../../viewmodels/notification_view_model.dart';
import '../atoms/tab.dart';
import '../modules/app_bar.dart';
import '../modules/search_module.dart';
import '../modules/socon_mysocon.dart';

class SoconBookScreen extends StatefulWidget {
  const SoconBookScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SoconBookScreenState();
  }
}

class _SoconBookScreenState extends State<SoconBookScreen> {
  final NotificationViewModel notificationViewModel = NotificationViewModel();
  final List<String> soconNames = [
    '소금빵',
    '마카롱',
    '상추',
    '소금빵',
    '마카롱',
    '상추',
    '소금빵',
    '마카롱',
    '상추',
  ];
  final List<String> storeNames = [
    '오소유',
    '빵집1',
    '마트1',
    '오소유',
    '빵집1',
    '마트1',
    '오소유',
    '빵집1',
    '빵집1'
  ];

  final List<String> dueDate = [
    '2024-02-11',
    '2024-02-10',
    '2025-06-09',
    '2024-02-11',
    '2024-02-10',
    '2025-06-09',
    '2024-02-11',
    '2024-02-10',
    '2025-06-09',
  ];
  final List<String> imageUrl = [
    "https://cataas.com/cat",
    "https://cataas.com/cat",
    "https://cataas.com/cat",
    "https://cataas.com/cat",
    "https://cataas.com/cat",
    "https://cataas.com/cat",
    "https://cataas.com/cat",
    "https://cataas.com/cat",
    "https://cataas.com/cat",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.WHITE,
        appBar: CustomAppBar(title: "소콘북"),
        body: Container(
            color: AppColors.WHITE,
            width: ResponsiveUtils.getWidthWithPixels(context, 320),
            margin: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.getWidthWithPixels(context, 20)),
            child: Column(
              children: [
                const SizedBox(height: 15.0),
                SearchModule(type: "soconbook"),
                const SizedBox(height: 10.0),
                Expanded(
                  child: TabBarScreen(
                    contents: {
                      '사용가능': mySoconList(),
                      '사용완료': mySoconList(),
                    },
                    marginTop: 0,
                  ),
                )
              ],
            )));
  }

  // 소콘 리스트
  Widget mySoconList() {
    return SingleChildScrollView(
      child: Container(
          color: AppColors.WHITE,
          width: ResponsiveUtils.getWidthPercent(context, 100),
          margin: const EdgeInsets.only(top: 10.0),
          // alignment: Alignment.center,
          // margin: EdgeInsets.symmetric(
          //     horizontal: ResponsiveUtils.getWidthWithPixels(context, 20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5.0,
              ),
              Text(
                "각 기프티콘은 구매하신 가게에서만 사용하실 수 있습니다.",
                style: TextStyle(
                  fontSize: ResponsiveUtils.calculateResponsiveFontSize(
                      context, FontSizes.XXXSMALL),
                  fontWeight: FontWeight.w400,
                  color: AppColors.GRAY400,
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 10.0,
              ),
              GridView.builder(
                shrinkWrap: true, // child 위젯의 크기를 정해주지 않은 경우 true로 지정해야됨
                physics: NeverScrollableScrollPhysics(),
                itemCount: soconNames.length, //item 개수
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                  childAspectRatio: 1 / 1.2, //item 의 가로 세로의 비율
                  mainAxisSpacing: 5, //수평 Padding
                  crossAxisSpacing: 5, //수직 Padding
                ),
                itemBuilder: (BuildContext context, index) {
                  return MySocon(
                    soconName: soconNames[index],
                    storeName: storeNames[index],
                    dueDate: dueDate[index],
                    imageUrl: imageUrl[index],
                  );
                },
              ),
            ],
          )),
    );
  }
}
