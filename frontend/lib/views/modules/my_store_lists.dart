import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:socon/services/mystore_lists_service.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/utils/responsive_utils.dart';
import 'package:socon/views/atoms/tag_icon.dart';
import 'package:socon/views/modules/store_detail_top_card.dart';
import 'package:socon/views/screens/myStore/store_register_view.dart';
import 'package:socon/views/atoms/image_loader.dart';
import 'package:socon/models/mystore_lists_model.dart';

class MyStoreLists extends StatefulWidget {

  const MyStoreLists({super.key});

  @override
  State<MyStoreLists> createState() => _MyStoreListsState();
}

class _MyStoreListsState extends State<MyStoreLists> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
          child: Text(
            '+ 점포 등록',
            style: TextStyle(color: AppColors.BLACK),
          ),
          style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            side: BorderSide(color: Colors.grey.shade300),
            padding: EdgeInsets.symmetric(vertical: 20),
          ).copyWith(
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return AppColors.YELLOW;
                return null; // 기본 상태에서는 변경 없음
              },
            ),
          )
        )
      )
    ]
  );
 }
}

class StoreLists extends StatefulWidget {
  const StoreLists({super.key});

  @override
  State<StoreLists> createState() => _StoreListsState();
}

class _StoreListsState extends State<StoreLists> {

  List<dynamic> myStores = [];

  @override
  void initState() {
    super.initState();
    loadMyStores();
  }

  void loadMyStores() async {
    debugPrint('내 점포리스트 요청중!');
    MystoreListsService service = MystoreListsService();
    var stores = await service.getMystoreLists();
    // debugPrint(stores as String?);
    setState(() {
      myStores = stores;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('8888888888888888888888888');
    print(myStores);
    print('8888888888888888888888888');
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: myStores.length,
        itemBuilder: (context, index) {
          final store = myStores[index];
          return InkWell(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => StoreDetailTopCard(storeId : store.storeId)));
              GoRouter.of(context).go("/myStores/${store.id}");
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
                  ]),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      height: 80,
                      width: 80,
                      child: ImageLoader(
                        imageUrl: store.image,
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
                              buttonText: store.category,
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
        Text(
          '아직 등록된 점포가 없어요',
          style: TextStyle(
              fontSize: FontSizes.MEDIUM, fontWeight: FontWeight.bold),
        ),
        Text(
          '점포를 등록해 주세요',
          style: TextStyle(
              fontSize: FontSizes.MEDIUM, fontWeight: FontWeight.bold),
        ),
      ],
    ));
  }
}
