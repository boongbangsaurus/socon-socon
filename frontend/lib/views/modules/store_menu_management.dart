import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socon/models/socon_card.dart';
import 'package:socon/viewmodels/store_product_view_model.dart';
import 'package:socon/views/modules/socon_storesocon.dart';
import 'package:socon/views/screens/myStore/store_product_register.dart';


class MenuManagement extends StatelessWidget {
  final int storeId;

  const MenuManagement({super.key, required this.storeId, });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductViewModel(),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ElevatedButton(

              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductRegister(storeId: storeId)));
              },
              child: Text('상품 등록'),
            ),
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true, // child 위젯의 크기를 정해주지 않은 경우 true로 지정해야됨
              itemCount: socons.length, //item 개수
              padding: EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                childAspectRatio: 1 / 1.2, //item 의 가로 세로의 비율
                mainAxisSpacing: 7, //수평 Padding
                crossAxisSpacing: 7, //수직 Padding
              ),
              itemBuilder: (BuildContext context, index) {
                final socon = socons[index];
                return StoreSoconLists(
                  soconName: socon.soconName!,
                  price: socon.price!,
                  imageUrl: socon.imageUrl ?? '',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
