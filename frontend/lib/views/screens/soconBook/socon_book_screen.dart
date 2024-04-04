import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/utils/string_utils.dart';
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
  List<dynamic>? usableList;
  List<dynamic>? usedMysoconList;

  late Future<Map<String, dynamic>?> _getMySoconList;

  MySoconViewModel _mySoconViewModel = MySoconViewModel();

  Future<Map<String, dynamic>?> _fetchMySoconList() async {
    try {
      await Future.delayed(Duration(seconds: 2));

      Map<String, dynamic>? mySoconListData =
          await _mySoconViewModel.getMySoconList();

      print("_fetchMySoconList result: $mySoconListData");
      return mySoconListData;
    } catch (error) {
      print("Error _fetchMySoconList: $error");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.WHITE,
      appBar: CustomAppBar(title: "소콘북"),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchMySoconList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic>? mySoconListData = snapshot.data;
            print("스냅샷을 찍어보자 $mySoconListData");

            if (mySoconListData != null) {
              usableList = mySoconListData["usable"];
              usedMysoconList = mySoconListData["unusable"];

              return Container(
                color: AppColors.WHITE,
                width: ResponsiveUtils.getWidthWithPixels(context, 320),
                margin: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.getWidthWithPixels(context, 20),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 15.0),
                    SearchModule(type: "soconbook", ),
                    const SizedBox(height: 10.0),
                    Expanded(
                      child: TabBarScreen(
                        contents: {
                          '사용가능':
                              availableMySoconList(usableList) ?? Container(),
                          '사용완료':
                              usedMySoconList(usedMysoconList) ?? Container(),
                        },
                        marginTop: 0,
                        tabHeight:
                            ResponsiveUtils.getHeightWithPixels(context, 400),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(child: Text('데이터가 없습니다.'));
            }
          }
        },
      ),
    );
  }

  // 소콘 리스트
  Widget availableMySoconList(data) {
    print("availableMySoconList $data");

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
                      soconName: data![index]['item_name'],
                      storeName: data![index]['store_name'],
                      dueDate : StringAndDateUtils.formatDateTime(data![index]['expired_at']),
                      imageUrl: data![index]['item_image'],
                      // soconName: soconNames[index],
                      // storeName: storeNames[index],
                      // dueDate: dueDate[index],
                      // imageUrl: imageUrl[index],
                      onPressed: () {
                        print("${data![index]['socon_id']} ");
                        GoRouter.of(context).go(
                            "/soconbook/detail/${data![index]['socon_id']}");
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

  Widget usedMySoconList(data) {
    print("usedMySoconList $data");
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
                      soconName: data![index]['item_name'],
                      storeName: data![index]['store_name'],
                      dueDate: StringAndDateUtils.formatDateTime(data![index]['expired_at']),
                      imageUrl: data![index]['item_image'],
                    );
                  },
                ),
            ],
          )),
    );
  }
}
