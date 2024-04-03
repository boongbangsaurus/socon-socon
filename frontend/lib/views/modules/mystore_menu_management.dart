import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socon/models/mystore_detail_menu.dart';
import 'package:socon/services/mystore_detail_menu_list_service.dart';
import 'package:socon/viewmodels/mystore_detail_menu_list_view_model.dart';
import 'package:socon/views/modules/add_menu_card.dart';
import 'package:socon/views/modules/mystore_menu_card.dart';
import 'package:provider/provider.dart';



class MenuManagement extends StatefulWidget {
  final int storeId;

  MenuManagement({
    super.key,
    required this.storeId,
  });

  @override
  State<MenuManagement> createState() => _MenuManagementState();
}

class _MenuManagementState extends State<MenuManagement> {
  final bool isOwner = false;

  // final List<Menu> storeMenuList = [
  //   Menu.fromJson({
  //     "id": 0, // 상품 id
  //     "name": "소금빵",
  //     "imageUrl": "https://cataas.com/cat",
  //     "price": 3000 // 상품 가격
  //   }),
  //   Menu.fromJson({
  //     "id": 1, // 상품 id
  //     "name": "감자",
  //     "imageUrl": "https://cataas.com/cat",
  //     "price": 3500 // 상품 가격
  //   }),
  // ];

  // 내 발급 목록 리스트 불러오기
  List<dynamic> myMenus = [];

  void initState() {
    super.initState();
    loadMyStores();
  }

  void loadMyStores() async {
    debugPrint('내점포 상세조회 - 발행소콘 목록!');
    MystoreMenuListViewModel viewModel = MystoreMenuListViewModel();
    var menus = await viewModel.mystoreMenuLists(widget.storeId);
    // print('njnjnjnjnjnjnjnjnjnjn');
    // print(menus);
    // print('njnjnjnjnjnjnjnjnjnjn');
    setState(() {
      myMenus = menus as List;
    });
  }


  // // API 서비스 테스트
  // void loadMyStores() async {
  //   debugPrint('내 점포리스트 요청중!');
  //   MystoreMenuService service = MystoreMenuService();
  //   var menus = await service.getMystoreMenuLists(widget.storeId);
  //   print('njnjnjnjnjnjnjnjnjnjn');
  //     print(menus);
  //     print('njnjnjnjnjnjnjnjnjnjn');
  //   setState(() {
  //     myMenus = menus as List;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final MystoreMenuListViewModel viewModel = Provider.of<MystoreMenuListViewModel>(context, listen: false);
  // print(myMenus);
    return Column(
      children: [
        SizedBox(height: 20.0,),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            // child 위젯의 크기를 정해주지 않은 경우 true로 지정해야됨
            itemCount: myMenus.length + 1,
            //item 개수
            padding: EdgeInsets.symmetric(horizontal: 20),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
              childAspectRatio: 1 / 1.2, //item 의 가로 세로의 비율
              mainAxisSpacing: 7, //수평 Padding
              crossAxisSpacing: 7, //수직 Padding
            ),
            itemBuilder: (BuildContext context, index) {
              if(myMenus != Null) {
                if(index == 0){
                  return AddMenuCard(storeId : widget.storeId,);
                }else{
                  final storeMenu = myMenus[index -1];
                  return StoreMenuCard(
                    storeId : widget.storeId,
                    id : storeMenu['id'],
                    name : storeMenu['name'],
                    price: storeMenu['price'],
                    image: storeMenu['image'],
                  );
                }
              } else {
                if(index == 0){
                  return AddMenuCard(storeId : widget.storeId,);
                }else{
                  return null;
                }
              }
            },
          ),
        ),
      ],
    );
  }
}

