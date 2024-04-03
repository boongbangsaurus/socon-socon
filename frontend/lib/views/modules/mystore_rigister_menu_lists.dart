import 'package:flutter/material.dart';
import 'package:socon/models/socon_card.dart';
import 'package:socon/viewmodels/mystore_detail_menu_list_view_model.dart';
import 'package:socon/views/modules/mystore_menu_card.dart';
import 'package:socon/views/modules/socon_storesocon.dart';


class RegisteredMenu extends StatefulWidget {
  final int storeId;

  const RegisteredMenu({super.key, required this.storeId});

  @override
  State<RegisteredMenu> createState() => _RegisteredMenuState();
}

class _RegisteredMenuState extends State<RegisteredMenu> {


  // 내 발급 목록 리스트 불러오기
  List<dynamic> myMenus = [];

  void initState() {
    super.initState();
    loadMyStores();
  }

  void loadMyStores() async {
    debugPrint('내점포 상세조회 - 발행소콘 목록!');
    MystoreMenuListViewModel viewModel = MystoreMenuListViewModel();
    var menus = await viewModel.mystoreRegisterMenuLists(widget.storeId);
    // print('njnjnjnjnjnjnjnjnjnjn');
    // print(menus);
    // print('njnjnjnjnjnjnjnjnjnjn');
    setState(() {
      myMenus = menus as List;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(myMenus);
    return Container(
      padding: EdgeInsets.only(top: 10),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: myMenus.length,
          padding: EdgeInsets.symmetric(horizontal: 20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
            childAspectRatio: 1 / 1.2, //item 의 가로 세로의 비율
            mainAxisSpacing: 7, //수평 Padding
            crossAxisSpacing: 7, //수직 Padding
          ),
          itemBuilder: (BuildContext context, index) {
            final socon = myMenus[index];
            return StoreMenuCard(
              storeId: widget.storeId,
              isOwner: true,
              id: socon['id'],
              name: socon['name'],
              is_main: socon['is_main'],
              issued_quantity: socon['issued_quantity'],
              left_quantity: socon['left_quantity'],
              price: socon['price'],
              is_discounted: socon['is_discounted'] ?? false,
              discounted_price: socon['discounted_price'],
              image: socon['image'] ?? '',
              createdAt: socon['createdAt'] ?? DateTime.now(),
            );
          },
        ),
    );
  }
}
