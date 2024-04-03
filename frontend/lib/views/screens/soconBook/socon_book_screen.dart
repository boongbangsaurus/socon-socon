import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
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
  late List<dynamic>? usableList;
  late List<dynamic>? usedMysoconList;
  final MySoconViewModel _mySoconViewModel = MySoconViewModel();
  late Future<Map<String, dynamic>?> _getMySoconList;

  @override
  void initState() {
    super.initState();
    _getMySoconList = _fetchMySoconList();
  }

  Future<Map<String, dynamic>?> _fetchMySoconList() async {
    Map<String, dynamic>? mySoconListData =
        await _mySoconViewModel.getMySoconList();
    if (mySoconListData != null) {
      setState(() {
        usableList = mySoconListData['usable'];
        usedMysoconList = mySoconListData['unusable'];
      });
    } else {
      print("소콘 목록을 가져오는 데 문제가 발생했습니다.");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      appBar: CustomAppBar(title: "소콘북"),
      body: _buildMySoconLists(),
      // body: FutureBuilder<Map<String, dynamic>?>(
      //   future: _getMySoconList,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     } else  {
      //       usableList = snapshot.data?['usable'];
      //       usedMysoconList = snapshot.data?['unusable'];
      //
      //       print("[screen] 사용 가능 $usableList");
      //       print("[screen] 사용 완료 $usedMysoconList");
      //
      //       return _buildMySoconLists();
      //     }
      //   },
      // ),
    );
  }

  Widget _buildMySoconLists() {
    if (usableList == null || usedMysoconList == null) {

      return Center(child: CircularProgressIndicator());
    }

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
                '사용가능': availableMySoconList(),
                '사용완료': usedMySoconList(),
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
  Widget availableMySoconList() {
    print("소콘 리스트트ㅡㅌ트ㅡㅌ------------------------ $usableList");

    return SingleChildScrollView(
      key: ObjectKey('available_my_socon_list'),
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
              if (usableList != null)
                GridView.builder(
                  key: ObjectKey('available_my_socon_grid'),
                  shrinkWrap: true,
                  // child 위젯의 크기를 정해주지 않은 경우 true로 지정해야됨
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: usableList!.length,
                  //item 개수
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                    childAspectRatio: 1 / 1.2, //item 의 가로 세로의 비율
                    mainAxisSpacing: 5, //수평 Padding
                    crossAxisSpacing: 5, //수직 Padding
                  ),
                  itemBuilder: (BuildContext context, index) {
                    return MySocon(
                      available: true,
                      soconName: usableList![index]['item_name'],
                      storeName: usableList![index]['store_name'],
                      dueDate: usableList![index]['expired_at'],
                      imageUrl: usableList![index]['item_image'],
                      // soconName: soconNames[index],
                      // storeName: storeNames[index],
                      // dueDate: dueDate[index],
                      // imageUrl: imageUrl[index],
                      onPressed: () {
                        print("${usableList![index]['socon_id']} ");
                        GoRouter.of(context).go("/soconbook/detail/${usableList![index]['socon_id']}");
                        // String soconId = usableList![index]['socon_id'];
                        // print("소콘 아이디야 $soconId");
                        // GoRouter.of(context).go("/soconbook/detail/${soconId}");
                      },
                    );
                  },
                ),
            ],
          )),
    );
  }

  Widget usedMySoconList() {
    return SingleChildScrollView(
      key: ObjectKey('used_my_socon_list'),
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
              if (usableList != null)
                GridView.builder(
                  key: ObjectKey('used_my_socon_grid'),
                  shrinkWrap: true,
                  // child 위젯의 크기를 정해주지 않은 경우 true로 지정해야됨
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: usedMysoconList!.length,
                  //item 개수
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                    childAspectRatio: 1 / 1.2, //item 의 가로 세로의 비율
                    mainAxisSpacing: 5, //수평 Padding
                    crossAxisSpacing: 5, //수직 Padding
                  ),
                  itemBuilder: (BuildContext context, index) {
                    return MySocon(
                      available: false,
                      soconName: usedMysoconList![index]['item_name'],
                      storeName: usedMysoconList![index]['store_name'],
                      dueDate: usedMysoconList![index]['expired_at'],
                      imageUrl: usedMysoconList![index]['item_image'],
                    );
                  },
                ),
            ],
          )),
    );
  }
}
