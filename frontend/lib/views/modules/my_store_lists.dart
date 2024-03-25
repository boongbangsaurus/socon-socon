import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/tag_icon.dart';
import 'package:socon/views/modules/store_detail_view.dart';
import 'package:socon/views/modules/store_register_view.dart';
import 'package:socon/views/atoms/image_loader.dart';
import 'package:socon/models/my_store.dart';

class MyStoreLists extends StatefulWidget {
  const MyStoreLists({super.key});

  @override
  State<MyStoreLists> createState() => _MyStoreListsState();
}

class _MyStoreListsState extends State<MyStoreLists> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          stores.isNotEmpty ? StoreLists() : NoStoreComment(),
          Container(
            width: ResponsiveUtils.getWidthPercent(context, 100),
            margin: EdgeInsets.only(bottom: 10),
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('+ 점포 등록', style: TextStyle(color: AppColors.BLACK),),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                side: BorderSide(color: Colors.grey.shade300),
                padding: EdgeInsets.symmetric(vertical: 20),
              ).copyWith(
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) return AppColors.YELLOW;
                    return null; // 기본 상태에서는 변경 없음
                  },
                ),
              ),
            ),
          )


          // Container(
          //   margin: EdgeInsets.all(20),
          //   width: double.infinity,
          //   // 화면 너비에 맞춤
          //   height: 48.0,
          //   // 적당한 높이
          //   decoration: BoxDecoration(
          //     // 그림자 추가
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.5),
          //         spreadRadius: 1,
          //         blurRadius: 2,
          //         offset: Offset(0, 2), // 그림자의 위치 조정
          //       ),
          //     ],
          //   ),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => RegisterPage()),
          //       );
          //     },
          //     style: ButtonStyle(
          //       backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          //             (Set<MaterialState> states) {
          //           if (states.contains(MaterialState.pressed)) {
          //             return Color(0xFFF8D461); // 클릭 시 배경색
          //           }
          //           return Colors.white; // 기본 배경색
          //         },
          //       ),
          //       foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          //             (Set<MaterialState> states) {
          //           if (states.contains(MaterialState.pressed)) {
          //             return Colors.black; // 클릭 시 글자색
          //           }
          //           return Colors.black; // 기본 글자색
          //         },
          //       ),
          //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //         RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(0),
          //           side: BorderSide(color: Colors.grey),
          //         ),
          //       ),
          //       elevation: MaterialStateProperty.resolveWith<double>(
          //             (Set<MaterialState> states) {
          //           if (states.contains(MaterialState.pressed)) {
          //             return 0; // 클릭 시 그림자 제거
          //           }
          //           return 4; // 기본 그림자
          //         },
          //       ),
          //     ),
          //     child: Text('+ 점포 등록'),
          //   ),
          // ),

        ]
    );
  }
}


class StoreLists extends StatelessWidget {
  const StoreLists({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: stores.length,
        itemBuilder: (context, index) {
          final store = stores[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => StoreDetailPage(storeId : store.storeId)));
            },
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(1, 2),
                    )
                  ]
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 80,
                      width: 80,
                      child: ImageLoader(
                        imageUrl: store.imageUrl,
                        borderRadius: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    flex: 2,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              store.name,
                              style: TextStyle(
                                  fontSize: FontSizes.LARGE,
                                  fontWeight: FontWeight.bold),
                            ),
                            TagIcon(
                              buttonText: store.tag,
                              buttonColor: Colors.amber,
                              buttonTextColor: Colors.white,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



class NoStoreComment extends StatelessWidget {
  const NoStoreComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('아직 등록된 점포가 없어요', style: TextStyle(fontSize: FontSizes.MEDIUM, fontWeight: FontWeight.bold),),
          Text('점포를 등록해 주세요', style: TextStyle(fontSize: FontSizes.MEDIUM, fontWeight: FontWeight.bold),),
        ],
      )
    );
  }
}
