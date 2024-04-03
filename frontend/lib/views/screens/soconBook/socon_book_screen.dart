import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/utils/toast_utils.dart';
import 'package:socon/viewmodels/my_socon_view_model.dart';
import 'package:socon/viewmodels/socon_coupon_view_model.dart';
import '../../../models/socon_card.dart';
import '../../../utils/colors.dart';
import '../../../utils/fontSizes.dart';
import '../../../viewmodels/notification_view_model.dart';
import '../../atoms/tab.dart';
import '../../modules/app_bar.dart';
import '../../modules/search_module.dart';
import '../../modules/socon_mysocon.dart';

class SoconBookScreen extends StatefulWidget {
  const SoconBookScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SoconBookScreenState();
  }
}

class _SoconBookScreenState extends State<SoconBookScreen> {
  final NotificationViewModel notificationViewModel = NotificationViewModel();
  late List<Socon> soconList;
  final List<dynamic> usableList = [];
  final List<dynamic> usedMysoconList = [];
  final MySoconViewModel _mySoconViewModel = MySoconViewModel();
  late Future<Map<String, dynamic>?> _getMySoconList;

  @override
  void initState() {
    super.initState();
    print("내 소콘북 목록 가져오기");
    _mySoconViewModel.getMySoconList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      appBar: CustomAppBar(title: "소콘북"),
      body: _buildMySoconLists(context, _mySoconViewModel),
    );
  }

  Widget _buildMySoconLists(
      BuildContext context, MySoconViewModel mySoconViewModel) {
    return Container(
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
                '사용가능': availableMySoconList(mySoconViewModel.usableList),
                '사용완료': usedMySoconList(mySoconViewModel.usedMysoconList),
              },
              marginTop: 0,
              tabHeight: ResponsiveUtils.getHeightWithPixels(context, 450),
            ),
          )
        ],
      ),
    );
  }

// 소콘 리스트
  Widget availableMySoconList(List<dynamic>? usableList) {
    print("[소콘리스트] 사용가능해 $usableList");

    if (usableList == null) {
      usableList = [];
    }
    return SingleChildScrollView(
      child: Container(
        color: AppColors.WHITE,
        width: ResponsiveUtils.getWidthPercent(context, 100),
        margin: const EdgeInsets.only(top: 10.0),
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
            if (usableList.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: usableList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (BuildContext context, index) {
                  return MySocon(
                    available: true,
                    soconName: usableList![index]['item_name'],
                    storeName: usableList[index]['store_name'],
                    dueDate: usableList[index]['expired_at'],
                    imageUrl: usableList[index]['item_image'],
                    onPressed: () {
                      print("${usableList![index]['socon_id']} ");
                      GoRouter.of(context).go(
                          "/soconbook/detail/${usableList![index]['socon_id']}");
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget usedMySoconList(List<dynamic>? usedMysoconList) {
    print("[소콘리스트] 사용못해 $usedMysoconList");

    if (usedMysoconList == null) {
      usedMysoconList = [];
    }

    return SingleChildScrollView(
      child: Container(
        color: AppColors.WHITE,
        width: ResponsiveUtils.getWidthPercent(context, 100),
        margin: const EdgeInsets.only(top: 10.0),
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
            if (usedMysoconList.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: usedMysoconList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (BuildContext context, index) {
                  return MySocon(
                    available: false,
                    soconName: usedMysoconList![index]['item_name'],
                    storeName: usedMysoconList[index]['store_name'],
                    dueDate: usedMysoconList[index]['expired_at'],
                    imageUrl: usedMysoconList[index]['item_image'],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

// Future<Map<String, dynamic>?> _fetchMySoconList() async {
//   await Future.delayed(Duration(seconds: 2));
//
//   Map<String, dynamic>? mySoconListData =
//   await _mySoconViewModel.getMySoconList();
//   print("[screen] 소콘북 소콘 목록  가져오기 성공 $mySoconListData");
//
//   if (mySoconListData != null) {
//     setState(() {
//       usableList = mySoconListData['usable'];
//       usedMysoconList = mySoconListData['unusable'];
//     });
//     return mySoconListData; // 수정: 반환 값 추가
//   } else {
//     print("소콘 목록을 가져오는 데 문제가 발생했습니다.");
//     return null; // 수정: 예외 발생 시 null 반환
//   }
// }
